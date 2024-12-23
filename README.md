# IdeaSubmissionForm.js
To collect user input for idea submissions
// frontend/src/components/IdeaSubmissionForm.js

import React, { usestate } from 'react';
import axios from 'axios';

const IdeaSubmissionForm = () => {
    const [title, setTitle] = useState('');
    const [description, setDescription] = useState('');
    const [category, setCategory] = useState('');
    const [error, setError] = useState(null);
    const [success, setSuccess] = useState(null);

    const handleSubmit = async (event) => {
        event.preventDefault();
        try {
            const response = await axios.post('/api/ideas', {
                title,
                description,
                category,
            });
            setSuccess('Idea submitted successfully!');
            setError(null);
            // Reset form fields
            setTitle('');
            setDescription('');
            setCategory('');
        } catch (err) {
            setError('Failed to submit idea. Please try again.');
            setSuccess(null);
        }
    };

    return (
        <div>
            <h2>Submit Your Idea</h2>
            <form onSubmit={handleSubmit}>
                <div>
                    <label>Title:</label>
                    <input type="text" value={title} onChange={(e) => setTitle(e.target.value)} required />
                </div>
                <div>
                    <label>Description:</label>
                    <textarea value={description} onChange={(e) => setDescription(e.target.value)} required />
                </div>
                <div>
                    <label>Category:</label>
                    <input type="text" value={category} onChange={(e) => setcategory(e.target.value)} />
                </div>
                <button type="submit">Submit</button>
                {error && <p className="error">{error}</p>}

// backend/src/models/Idea.js

const mongoose = require('mongoose');

const IdeaSchema = new mongoose.Schema({
    title: { type: String, required: true },
    description: { type: String, required: true },
    category: { type: String, required: false },
    submittedAt: { type: Date, default: Date.now },
});

module.exports = mongoose.model('Idea', IdeaSchema);

                
                {success && <p className="success">{success}</p>}  </form> </div>);};
export default IdeaSubmissionForm;

// backend/src/controllers/ideaController.js

const Idea = require('../models/Idea');

exports.submitIdea = async (req, res) => {
    try {
        const { title, description, category } = req.body;
        const newIdea = new Idea({ title, description, category });
        await newIdea.save();
        res.status(201).json({ message: 'Idea submitted successfully!' });
    } catch (error) {
        res.status(400).json({ error: 'Failed to submit idea.' });
    }
};
// backend/src/routes/ideaRoutes.js

const express = require('express');
const router = express.Router();
const ideaController = require('../controllers/ideaController');

router.post('/', ideaController.submitIdea);

module.exports = router;

// backend/src/server.js

const express = require('express');
const mongoose = require('mongoose');
const ideaRoutes = require('./routes/ideaRoutes');

const app = express();
app.use(express.json()); // for parsing application/json

// MongoDB connection
mongoose.connect('mongodb://localhost/green_future', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

// Routes
app.use('/api/ideas', ideaRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
