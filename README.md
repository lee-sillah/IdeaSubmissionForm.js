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

                
                {success && <p className="success">{success}</p>}
            </form>
        </div>
    );
};

export default IdeaSubmissionForm;
