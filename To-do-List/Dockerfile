# Use official nginx image
FROM nginx:alpine

# Copy your HTML file(s) into the nginx html directory
COPY ./index.html /usr/share/nginx/html/index.html

# Expose port 80 (default nginx port)
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
