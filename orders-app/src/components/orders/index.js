import React from 'react';
import { all } from '../../api/orders';
import { getAllVariants } from '../../api/products';
import { Loading } from '../loading';
import { OrderRow } from './order_row';
import './index.css';

export class OrdersIndex extends React.Component {
    constructor() {
        super();
        this.orderId = 1;
        this.state = {
            isLoading: true
        };
    }
    async componentDidMount() {
        document.title = 'All Orders | Order App'
        const orders = await all().then((resp) => resp.data);
        const variants = await this.flattenVariants();
        this.setState({
            orders,
            isLoading: false,
            variants
        });
    }
    render() {
        if (this.state.isLoading) {
            return <Loading />;
        }
        return (
            <div className="container">
                <div className="row">
                    <h2>All Orders</h2>
                </div>
                <div className="row">
                    <table>
                        <thead>
                            <tr>
                                <th>Order #</th>
                                <th>Customer Name</th>
                                <th>Product</th>
                                <th>Status</th>
                                <th>Total</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            {this.renderOrders()}
                        </tbody>
                    </table>
                </div>
            </div>
        );
    }

    renderOrders() {
        if (this.state.orders.length === 0) {
            return <tr><td>No orders found.</td></tr>
        }
        return this.state.orders.map((o, idx) => {
            const v = this.state.variants[o.order_variant[0].variant_id];
            return (
                <OrderRow order={o} variant={v} key={idx} />
                /*
                <tr key={idx}>
                    <td>{o.id}</td>
                    <td>{o.customer.name}</td>
                    <td>{v.product.name} / {v.name}</td>
                    <td>{o.status}</td>
                    <td>${((o.subtotal + o.sales_tax) / 100).toFixed(2)}</td>
                    <td><a href={`orders/${o.id}/edit`}>Edit</a></td>
                </tr>
                */
            );
        })
    }

    async flattenVariants() {
        const variants = {};
        await getAllVariants().then((resp) => {
            resp.data.forEach((v) => {
                variants[v.id] = v;
            })
        });
        return variants;
    }
}
