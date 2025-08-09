# Deployment Instructions

This project is packaged and deployed using Docker.  
The application is defined in a `Dockerfile` that installs all necessary dependencies and starts the Lighthouse CI server.

## Steps Taken for Deployment

1. **Prepare the Docker image**  
   - The `Dockerfile` installs Node.js, Lighthouse CI CLI, Lighthouse CI Server, and `sqlite3`.  
   - It also creates a `/data` directory to store the SQLite database and exposes port `9001`.  
   - The container entrypoint runs:  
     ```bash
     lhci server --port=9001 --storage.storageMethod=sql --storage.sqlDatabasePath=/data/lhci.db
     ```

2. **Push the code to GitHub**  
   - All project files, including the `Dockerfile`, were committed and pushed to a GitHub repository.

3. **Deploy to Render**  
   - A new **Web Service** was created in [Render](https://render.com).  
   - The GitHub repository was connected and the branch with the `Dockerfile` was selected.  
   - Render automatically built the image using the `Dockerfile`.  
   - Port `9001` (declared in `EXPOSE`) was used for incoming traffic.  
   - A persistent disk was mounted at `/data` to store the Lighthouse CI database.

4. **Access the service**  
   - Once deployment completed, Render provided a public URL to access the Lighthouse CI server.

## Deployment Diagram

```mermaid
flowchart LR
    A[Local Environment] -->|Commit & Push| B[GitHub Repository]
    B -->|Connect Repo| C[Render Web Service]
    C -->|Builds Dockerfile| D[Docker Image on Render]
    D -->|Runs Container| E[Public URL]
```