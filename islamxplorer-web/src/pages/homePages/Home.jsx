import * as React from 'react';
import { motion } from "framer-motion";
import { Card, CardActionArea, CardContent, CardMedia, Container, Snackbar, Typography } from '@mui/material';



import { WordCarousel } from '../../components/items/wordCarousel/wordCarousel';

import service1 from "../../../src/assets/images/services-images/Oriental Design 3.1.png";
import service2 from "../../../src/assets/images/services-images/Oriental Design 3.2.png";
import service3 from "../../../src/assets/images/services-images/Oriental Design 3.3.png";
import service4 from "../../../src/assets/images/services-images/Oriental Design 3.4.png";
import service5 from "../../../src/assets/images/services-images/Oriental Design 3.5.png";

import mockupa from "../../../src/assets/images/mockups/mockup-a.png"
import ItemCarousel from './ItemCarousel';

import './home_styles.scss';

export const Home = () => {
  

  return (
    <div id='home_div'>
      <section className={'opener'}>
        <header>
        <h1 className={"opener"} aria-label="Easily Searchable Quran O Hadith">
          <span className={"headline-top"}>Explore <WordCarousel /></span>
          <span className={"headline-bottom"}>With Knowledge Graphs.</span>
        </h1>
        </header>
        <section className={'services'}>
        <div className={'top-row'}>
        <motion.div
          initial={{ scale: 0 }}
          animate={{ scale: "100%" }}
          transition={{
            type: "spring",
            stiffness: 200,
            damping: 40,
            duration: 0.1
          }}
        >
          <Card sx={{ maxWidth: 345 }}>
            <CardActionArea>
              <CardMedia
                component="img"
                height="140"
                image={service1}
                alt="knowledge graph"
                className={'serviceImg'}
              />
              <CardContent>
                <Typography gutterBottom variant="h5" component="div">
                  Knowledge Graph
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  Explore the intricacies of Islam with our dynamic Knowledge Graph unravelling the themes of Quran and Ahadith to deepen your understanding
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>
          </motion.div>
          <motion.div
          initial={{ scale: 0 }}
          animate={{ scale: "100%" }}
          transition={{
            type: "spring",
            stiffness: 200,
            damping: 40,
            duration: 0.1
          }}
        >
          <Card sx={{ maxWidth: 345 }}>
            <CardActionArea>
              <CardMedia
                component="img"
                height="140"
                image={service2}
                alt="search"
                className={'serviceImg'}
              />
              <CardContent>
                <Typography gutterBottom variant="h5" component="div">
                  Search Engine
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  Introducing a Thematic Search Engine, your gateway to a treasure trove of Islamic knowledge. Immerse yourself in a seamless exploration of Quran and Ahadith
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>
          </motion.div>
          <motion.div
          initial={{ scale: 0 }}
          animate={{ scale: "100%" }}
          transition={{
            type: "spring",
            stiffness: 200,
            damping: 40,
            duration: 0.1
          }}
        >
          <Card sx={{ maxWidth: 345 }}>
            <CardActionArea>
              <CardMedia
                component="img"
                height="140"
                image={service3}
                alt="islamic routines"
                className={'serviceImg'}
              />
              <CardContent>
                <Typography gutterBottom variant="h5" component="div">
                  Islamic Routines
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  Immerse yourself in a holistic experience that encompasses Duas, Qibla Finding, Masjid Locator, and many other things elevating your spiritual journey
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>
          </motion.div>
        </div>
        <div class='bottom-row'>
        <motion.div
          initial={{ scale: 0 }}
          animate={{ scale: "100%" }}
          transition={{
            type: "spring",
            stiffness: 200,
            damping: 40,
            duration: 0.1
          }}
        >
          <Card sx={{ maxWidth: 345 }}>
            <CardActionArea>
              <CardMedia
                component="img"
                height="140"
                image={service4}
                alt="learn quran"
                className={'serviceImg'}
              />
              <CardContent>
                <Typography gutterBottom variant="h5" component="div">
                  Learn Quran
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  Learn the meaning of Quran by exploring its themes and topics. Understand the true concept behind the teachings of Ahadith, and how they are interconnected with the Quran
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>
          </motion.div>
          <motion.div
          initial={{ scale: 0 }}
          animate={{ scale: "100%" }}
          transition={{
            type: "spring",
            stiffness: 200,
            damping: 40,
            duration: 0.1
          }}
        >
          <Card sx={{ maxWidth: 345 }}>
            <CardActionArea>
              <CardMedia
                component="img"
                height="140"
                image={service5}
                alt="contribute"
                className={'serviceImg'}
              />
              <CardContent>
                <Typography gutterBottom variant="h5" component="div">
                  Contribute
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  Sign Up to become a Scholar, and add to our existing Knowledge Graph. Create your own ontologies, and share your knowledge with the world 
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>
          </motion.div>
        </div>
        </section>
      </section>


      <section className={'item-showcase'}>
        <ItemCarousel />
      </section>

      <section className={'testimonials'}>
        <div className='testimonial'>
          <p className='testimonial'>“With product inclusion, it’s really looking end to end at the design and development process and saying: Who else needs to be in the room? Who else do we need to have perspective from? And I think co-creating is really integral to building a product that actually suits the world.”</p>
          <div>
          <img src="http://placehold.it/100x100" alt="Dummy Image" />
            <div>
              <p>Some Name of a Person</p>
              <p>Some long designation of that Person</p>
            </div>
          </div>
        </div>
        <div className='testimonial'>
          <p className='testimonial'>“With product inclusion, it’s really looking end to end at the design and development process and saying: Who else needs to be in the room? Who else do we need to have perspective from? And I think co-creating is really integral to building a product that actually suits the world.”</p>
          <div>
          <img src="http://placehold.it/100x100" alt="Dummy Image" />
            <div>
              <p>Some Name of a Person</p>
              <p>Some long designation of that Person</p>
            </div>
          </div>
        </div>
      </section>

      <section className={'badges'}>
        <motion.div
          initial={{ y: 20 }}
          animate={{ y:-20 }}
          transition={{
            type: "spring",
            stiffness: 100,
            damping: 40,
            repeat: Infinity,
            repeatType: "mirror",
            repeatDelay: 0.1,
          }}
        >
          <img src={mockupa} className='mockup'/>
          
        </motion.div>
        <div>
          <div>
            <h1>Avaliable on Google Play</h1>
            <p className={'slogan'}>Download Our App Now to enjoy a bunch of Features on the go</p>
          </div>
          <div className={'spacer'}></div>
          <a target='_blank' href='https://play.google.com/store/apps/details?id=com.islamxplorer.islamxplorer_flutter&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'>
            <img className={'badge'} alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png'/>
          </a>
        </div>
      </section>

      {/* <section>
        <Example />
      </section> */}
    </div>
  );
}
