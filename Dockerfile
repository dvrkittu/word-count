# Use an official Python image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy FastAPI app and input file
COPY app.py /app/
COPY inputlog.txt /app/

# Install dependencies
RUN pip install fastapi uvicorn

# Expose the port for FastAPI
EXPOSE 8000

# Start FastAPI server with Uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
