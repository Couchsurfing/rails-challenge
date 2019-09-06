import React from 'react';
import { update } from '../../api/orders';
import './index.css';

export class OrderRow extends React.Component {
    constructor() {
        super();
        this.state = {
            isEditing: false
        };
        this.renderStatus = this.renderStatus.bind(this);
        this.renderUpdateButton = this.renderUpdateButton.bind(this);
    }
    render() {
        const o = this.props.order;
        const v = this.props.variant;
        return (
            <tr>
                <td>{o.id}</td>
                <td>{o.customer.name}</td>
                <td>{v.product.name} / {v.name}</td>
                <td>{this.renderStatus()}</td>
                <td>${((o.subtotal + o.sales_tax) / 100).toFixed(2)}</td>
                <td>{this.renderUpdateButton()}</td>
            </tr>
        );
    }
    async toggleEdit() {
        if(this.state.isEditing && this.props.order.status !== this.state.status) {
            // trigger patch
            await update(this.props.order.id, this.state.status).then((resp) => {
                this.props.order.status = this.state.status;
            }).catch((err) => {
                console.error("error updating status", err);
            })
        }
        this.setState({
            isEditing: !this.state.isEditing
        });
    }
    renderStatus() {
        if(this.state.isEditing) {
            return (
                <select onChange={(event) => this.setState({status: event.target.value})} defaultValue={this.props.order.status}>
                    <option value="pending">pending</option>
                    <option value="processing">processing</option>
                    <option value="fulfilled">fulfilled</option>
                    <option value="delivered">delivered</option>
                    <option value="canceled">canceled</option>
                </select>
            )
        }
        return this.props.order.status;
    }
    renderUpdateButton() {
        if(this.state.isEditing) {
            return <button type="button" className="btn btn-secondary" onClick={() => this.toggleEdit()}>Save</button>;
        }
        return <button type="button" className="btn btn-secondary" onClick={() => this.toggleEdit()}>Edit</button>
    }
}
