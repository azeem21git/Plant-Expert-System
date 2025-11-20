const express = require('express');
const { createServer } = require('http');
const { exec } = require('child_process');
const path = require('path');

const app = express();
const port = 3000;

// Serve static files
app.use(express.static(__dirname));

// Start Prolog server
const prologServer = exec('swipl plant_expert_system.pl', (error, stdout, stderr) => {
    if (error) {
        console.error(`Error starting Prolog server: ${error}`);
        return;
    }
});

// Forward API requests to Prolog server
app.get('/recommend', async (req, res) => {
    try {
        const response = await fetch(`http://localhost:8080/recommend?${new URLSearchParams(req.query)}`);
        const data = await response.json();
        res.json(data);
    } catch (error) {
        console.error('Error forwarding request to Prolog:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// Create HTTP server
const server = createServer(app);

// Start server
server.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});