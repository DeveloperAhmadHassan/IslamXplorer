import React from 'react';
import Carousel from 'react-material-ui-carousel'
import { Paper, Button } from '@mui/material'

export default function ItemCarousel(props)
{
    var items = [
        {
            name: "Random Name #1",
            description: "Probably the most random thing you have ever seen!"
        },
        {
            name: "Random Name #2",
            description: "Hello World!"
        },
        {
            name: "Random Name #3",
            description: "Hello World!"
        },
        {
            name: "Random Name #4",
            description: "Hello World!"
        },
        {
            name: "Random Name #5",
            description: "Hello World!"
        }
    ]

    return (
        <div id='carousel-container'>
            <Carousel sx={{width:"100%"}} autoPlay={true} fullHeightHover={false}  animation='slide' swipe={true} duration={1000}>
            {
                items.map( (item, i) => <Item key={i} item={item} /> )
            }
            </Carousel>
        </div>
    )
}

function Item(props)
{
    return (
        <div className={'main-card'}>
            <div><h1>{props.item.name}</h1></div>
            <div><p>{props.item.description}</p></div>
        </div>
    )
}