# build stage
FROM python:3.7-buster as build
ENV DOCKER_STAGE=build PYTHONUNBUFFERED=1

RUN pip install cython numpy
COPY requirements.txt .
RUN pip wheel --wheel-dir /wheels --find-links /wheels -r requirements.txt

# run stage
FROM python:3.7-slim-buster as run
ENV DOCKER_STAGE=run PYTHONUNBUFFERED=1

# Requirements
COPY --from=build /wheels /wheels
RUN pip --no-cache-dir install --find-links /wheels --no-index /wheels/* && rm -rf /wheels

# Download Spacy model
RUN python -m spacy download en

# Download Benepar model
RUN python -c 'import benepar; benepar.download("benepar_en2")'

# Python app
COPY . /app
WORKDIR /app

# start the app
CMD ["python", "/app/test.py"]
