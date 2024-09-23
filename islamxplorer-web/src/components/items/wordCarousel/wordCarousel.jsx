import React from 'react';
import './styles.css';

export const WordCarousel = () =>{
    return(<>
        <span id="content-slider">
        <span class="slider" style="
    left: 28%;
    position: relative;
">
            <span class="mask">
            <ul>
                <li class="anim1">
                <span class="quote"><h2>Islam</h2></span>
                </li>
                <li class="anim2">
                <span class="quote"><h2>Quran</h2></span>
                </li>
                <li class="anim3">
                <span class="quote"><h2>Ahadith</h2></span>
                </li>
                <li class="anim4">
                <span class="quote"><h2>Islam</h2></span>
                </li>
                <li class="anim5">
                <span class="quote"><h2>Quran</h2></span>
                </li>
            </ul>
            </span>
        </span>
        </span>
    </>);
}