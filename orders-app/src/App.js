import React from 'react';
import './App.css';
import { Nav } from './components/nav';
import { OrdersCreate } from './components/orders/create';
import { OrdersIndex } from './components/orders/index';
import { BrowserRouter as Router, Route, Link } from "react-router-dom";

function App() {
  return (
    <Router>
      <div>
        <Nav />
        <div className="container">
          <div className="row">
            <Route path="/" exact component={OrdersIndex} />
            <Route path="/create" exact component={OrdersCreate} />
          </div>
        </div>
      </div>
    </Router>
  );
}

//<OrdersCreate />

export default App;
