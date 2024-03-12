# https://platform.openai.com/docs/tutorials/meeting-minutes
# python -m venv env
# source env/bin/activate
# pip install openai
# pip install python-docx

# Gotta split into ~10MB files because 25MB is the theoretical max
# ffmpeg -i /Users/jhannah/Dropbox/Public/jay_flaunts/043.mp3 -f segment -segment_time 1200 -c copy ./out%03d.mp3
# In vim: gq to add hard word wrapping

from openai import OpenAI

client = OpenAI()  # defaults to os.environ.get("OPENAI_API_KEY")

from docx import Document

def transcribe_audio(audio_file_path):
  with open(audio_file_path, 'rb') as audio_file:
    transcription = client.audio.transcriptions.create(
      model="whisper-1",
      file=audio_file,
    )
  return transcription

transcription = transcribe_audio("out001.mp3")
print(transcription.text)


