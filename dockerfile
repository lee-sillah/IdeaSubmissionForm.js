services:
  - type: web
    name: idea-submission-backend
    env: node
    plan: free
    buildCommand: npm install
    startCommand: npm start
    repo: https://github.com/your-username/idea-submission 
    branch: main

  - type: static
    name: idea-submission-frontend
    env: static
    plan: free
    publish: ./frontend/build
    repo: https://github.com/your-username/your-frontend-repo
    branch: main
