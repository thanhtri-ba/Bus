module.exports = {
  apps: [
    {
      name: 'busz-backend',
      script: 'backend/dist/index.js',
      instances: 'max',
      exec_mode: 'cluster',
      env: {
        NODE_ENV: 'production',
      }
    }
  ]
};
