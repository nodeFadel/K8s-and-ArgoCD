#!/bin/bash

IMAGE="python:3.4-alpine"

trivy image --severity CRITICAL,HIGH $IMAGE
