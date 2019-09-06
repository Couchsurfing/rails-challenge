import React from 'react';
import { get as getCustomers } from '../../api/customers';
import { get as getProducts, getVariants } from '../../api/products';
import { Loading } from '../loading';
import './create.css';
import { instance } from '../../api/global';

export class OrdersCreate extends React.Component {

    constructor() {
        super();
        this.state = { loading: true };
    }
    async componentDidMount() {
        document.title = 'Create Order | Order App'
        // load products and customers
        await Promise.all([
            getCustomers().then((resp) => this.customers = resp.data),
            getProducts().then((resp) => this.products = resp.data)
        ]);
        this.setState({
            loading: false,
            isSubmitting: false,
            alerts: {}
        })

    }
    render() {
        if (this.state.loading) {
            return <Loading />;
        }
        return (
            <div className="container">
                <div className="row">
                    <h2>Create Order</h2>
                </div>
                <div className="row">
                    {this.generateAlerts()}
                </div>
                <div className="row">
                    <form onSubmit={this.submit}>
                        <div className="form-group">
                            <label>Customer</label>
                            <select name="customer" onChange={(event) => this.setState({ customer: event.target.value})} defaultValue={this.state.customer}>
                                <option>Select One</option>
                                {this.buildCustomerList()}
                            </select>
                        </div>
                        <div className="form-group">
                            <label>Product</label>
                            <select name="product" onChange={(event) => this.loadVariants(event)} defaultValue={this.state.product}>
                                <option>Select One</option>
                                {this.buildProductList()}
                            </select>
                        </div>
                        <div className="form-group">
                            <label>Variants</label>
                            <select name="variant" onChange={(event) => this.setState({ selectedVariant: event.target.value})} defaultValue={this.state.selectedVariant}>
                                {this.buildVariantList()}
                            </select>
                        </div>
                        <div className="form-group">
                            <label>Quantity</label>
                            <input name="quantity" type="text" onChange={(event) => this.setState({ quantity: event.target.value })} defaultValue={this.state.quantity} />
                        </div>
                        <button type="submit" className="btn btn-primary" onClick={(event) => this.submit(event)} disabled={this.state.isSubmitting}>Submit Order</button>
                    </form>
                </div>
            </div>
        );
    }

    generateAlerts() {
        const alerts = [];
        if (this.state.alerts && this.state.alerts.error) {
            alerts.push(<div className="alert alert-danger" role="alert" key="error">
                {this.state.alerts.error}
            </div>);
        }
        if (this.state.alerts && this.state.alerts.success) {
            alerts.push(<div className="alert alert-success" role="alert" key="error">
                {this.state.alerts.success}
            </div>);
        }
        return alerts;
    }

    submit(event) {
        event.preventDefault();
        this.setState({
            isSubmitting: true
        });
        // validate
        if (!this.state.customer || !this.state.selectedVariant || !this.state.quantity) {
            this.setState({
                alerts: {
                    error: 'Please complete the form before submitting.'
                },
                isSubmitting: false
            });
            console.log('validation failed', this.state);
        } else {
            instance.post('/api/orders', {
                customer_id: this.state.customer,
                order_variant: [{
                    variant_id: this.state.selectedVariant,
                    quantity: parseInt(this.state.quantity)
                }]
            }).then((response) => {
                this.setState({
                    isSubmitting: false,
                    alerts: {
                        success: 'Order created'
                    },
                    selectedVariant: null,
                    quantity: null,
                    product: null,
                    customer: null
                });
                console.log(this.state);
            }).catch((err) => {
                this.setState({
                    isSubmitting: false,
                    alerts: {
                        error: err
                    }
                });
            })
        }
    }

    buildCustomerList() {
        return this.customers.map((c) => {
            return (<option value={c.id} key={c.id}>{c.name}</option>)
        });
    }

    buildProductList() {
        return this.products.map((p) => {
            return (<option value={p.id} key={p.id}>{p.name}</option>);
        })
    }

    loadVariants(event) {
        this.setState({
            product: event.target.value
        });
        getVariants(event.target.value).then((response) => {
            this.setState({
                variants: response.data,
                selectedVariant: response.data[0].id
            });
        })
    }

    buildVariantList() {
        if (!this.state.variants || this.state.variants.length === 0) {
            return (<option>Select a product</option>);
        }
        return this.state.variants.map((v) => {
            return (<option value={v.id} key={v.id}>{v.name}</option>);
        });
    }
}
