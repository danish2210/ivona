module Ivona::Speech
  class << self
    # Helper. Gathers params for the create_speech_file method defined below.
    def get_speech_file_params(text, voice, codec_id='mp3/22050' )
      token        = Ivona::Auth.get_token
      md5          = Ivona::GetMd5.formula(token)
      content_type = 'text/plain'
      voice_id     = voice
      codec_id     = Ivona::Config.codec_id
      {  token:       token,
         md5:         md5,
         text:        text,
         contentType: content_type,
         voiceId:     voice_id,
         codecId:     codec_id  }
    end

    # Get a url for a speech file generated from uploaded text.
    def create_speech_file( text, voice='en_us_salli')
      HTTParty.post("#{BASE_URL}/speechfiles", {:body=>get_speech_file_params( text, voice)})
    end

    # Get a url for a speech file generated from uploaded text and for a text file with speech 
    # marks describing the positions of the text entities in a speech file.
    def create_speech_file_with_marks( text, voice='en_us_salli' )
      HTTParty.post("#{BASE_URL}/speechfileswithmarks", {:body=>get_speech_file_params( text, voice )})
    end

    # Delete a single speech file data
    # Result: success (int: 0/1) – success (1) or failure (0) of the operation
    def delete_speech_file( file_id )
      token  = Ivona::Auth.get_token
      md5    = Ivona::GetMd5.formula(token)
      params = [  "token=#{token}",
                  "md5=#{md5}"  ]
      params = params.join('&')
      HTTParty.delete("#{BASE_URL}/speechfiles/#{file_id}?#{params}")
    end

    # Get a list of all active speech files for the current user
    def list_speech_files
      token  = Ivona::Auth.get_token
      md5    = Ivona::GetMd5.formula(token)
      params = [  "token=#{token}",
                  "md5=#{md5}"  ]
      params = params.join('&')
      HTTParty.get("#{BASE_URL}/speechfiles?#{params}")
    end

    # Getting data of single utterance
    def get_speech_file_data( file_id )
      token  = Ivona::Auth.get_token
      md5    = Ivona::GetMd5.formula(token)
      params = [  "token=#{token}",
                  "md5=#{md5}"  ]
      params = params.join('&')
      HTTParty.get("#{BASE_URL}/speechfiles/#{file_id}?#{params}")
    end
  end
end