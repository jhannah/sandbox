# https://platform.openai.com/docs/tutorials/meeting-minutes
# python -m venv env
# source env/bin/activate
# pip install openai
# pip install python-docx

# Gotta split into ~10MB files because 25MB is the theoretical max
# ffmpeg -i /Users/jhannah/Dropbox/Public/jay_flaunts/043.mp3 -f segment -segment_time 1200 -c copy ./out%03d.mp3
# In vim: gq to add hard word wrapping

# python whisper.py ~/Dropbox/Hasani_Lee/20240507\ Douglas_CR20__sel_9-15-03_to_9-15-53.mp3

from openai import OpenAI
import argparse
import re

client = OpenAI()  # defaults to os.environ.get("OPENAI_API_KEY")


parser = argparse.ArgumentParser()
parser.add_argument("input", help="Input audio file.", type=str)
args = parser.parse_args()


def transcribe_audio(audio_file_path):
  with open(audio_file_path, 'rb') as audio_file:
    transcription = client.audio.transcriptions.create(
      model="whisper-1",
      file=audio_file,
    )
  return transcription


transcription = transcribe_audio(args.input)
text_file_path = re.sub('mp3$', 'txt', args.input)
print("writing file", text_file_path)
with open(text_file_path, 'w') as f:
  f.write(transcription.text)
