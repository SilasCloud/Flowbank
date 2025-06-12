# Use an official lightweight Python image
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire application code
COPY . .

# Set environment variable to match your preferred port
ENV PORT=5001

# Expose port 5001 to the host
EXPOSE 5001

# Run the application
CMD ["python", "app.py"]
