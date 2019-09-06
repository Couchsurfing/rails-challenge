import React from 'react';
import {Link} from 'react-router-dom';

export class Nav extends React.Component {
    render() {
        return (
            <nav className="navbar navbar-expand-lg navbar-light bg-light">
                <Link className="navbar-brand" to="/">Order App</Link>
                <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span className="navbar-toggler-icon"></span>
                </button>
                <div className="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul className="navbar-nav mr-auto">
                        <li className="nav-item">
                            <Link className="nav-link" to="/">All Orders</Link>
                        </li>
                        <li className="nav-item">
                            <Link className="nav-link" to="/create">Create Order</Link>
                        </li>
                    </ul>
                </div>
            </nav>
        );
    }
}
