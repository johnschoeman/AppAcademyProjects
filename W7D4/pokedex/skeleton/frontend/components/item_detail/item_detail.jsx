import React from 'react';

class ItemDetail extends React.Component {
  constructor(props) {
    super(props);
  }


  render() {
    console.log(this.props.item);
    let item = this.props.item;
    return (<div>
      <ul>
        <li>Name:
          {item.name}
        </li>
        <li>Happiness:
          {item.happiness}
        </li>
        <li>Price:
          {item.price}
        </li>

      </ul>
            </div>);
  }

}

export default ItemDetail;
