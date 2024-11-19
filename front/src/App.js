import React, { useEffect, useState } from 'react';
import axios from 'axios';

const REACT_APP_API_HOST='http://localhost';
const REACT_APP_API_PORT='3000';

function App() {
    const [counter, setCounter] = useState({ current: 0, updated: 0 });

    useEffect(() => {
        const fetchCounter = async () => {
            try {
                const response = await axios.get(`${REACT_APP_API_HOST}:${REACT_APP_API_PORT}/counter`);
                setCounter(response.data);
            } catch (error) {
                console.error('Error fetching counter:', error);
            }
        };

        fetchCounter();
        const interval = setInterval(fetchCounter, 10000); // Poll every 10 seconds
        return () => clearInterval(interval);
    }, []);

    return (
        <div style={{ textAlign: 'center', marginTop: '50px' }}>
            <h1>Counter App</h1>
            <p>Current Count: {counter.current}</p>
            <p>Updated Count: {counter.updated}</p>
        </div>
    );
}

export default App;
