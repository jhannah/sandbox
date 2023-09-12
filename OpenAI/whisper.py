# https://platform.openai.com/docs/tutorials/meeting-minutes
# pip3 install openai

import openai

def transcribe_audio(audio_file_path):
  with open(audio_file_path, 'rb') as audio_file:
    transcription = openai.Audio.transcribe("whisper-1", audio_file)
  return transcription['text']

text = transcribe_audio("/Users/jhannah/Dropbox/Public/jay_flaunts/025.mp3")
print(text)


