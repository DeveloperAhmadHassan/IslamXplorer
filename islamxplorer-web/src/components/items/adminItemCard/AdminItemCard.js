import React from 'react';
import "./styles.scss";


function AdminItemCard(props){
    return (
        <div className='admin-item-card'>
            <div className='title-cont'><h1 className='title'>{props.title}</h1></div>
            <img src={props.imagePath} />
        </div>
    )
}

export default AdminItemCard;