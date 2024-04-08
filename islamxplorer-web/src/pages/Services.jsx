import React from "react";
import AdminItemCard from "../components/items/adminItemCard/AdminItemCard";
import addDuaImg from "../../src/assets/images/man_praying_v1.png"
import { NavLink } from "react-router-dom";

export const Services = () => {
  let arr =[
    {
      "id":1,
      "name": "Add Verse",
      "imagePath":addDuaImg,
      "pagePath":"/add-verse"
    },
    {
      "id":2,
      "name": "Add Hadith",
      "imagePath":addDuaImg,
      "pagePath":"/add-hadith"
    },
    {
      "id":3,
      "name": "Add Dua",
      "imagePath":addDuaImg,
      "pagePath":"/add-dua"
    },
    {
      "id":4,
      "name": "Add Surah",
      "imagePath":addDuaImg,
      "pagePath":"/add-surah"
    },
    {
      "id":4,
      "name": "Add Ontology",
      "imagePath":addDuaImg,
      "pagePath":"/add-ontology"
    }
  ]
  return (
    <section id="admin-items">
      {arr.map(function (item) {
        return (<>
          <NavLink className="service-link" to={`/services${item.pagePath}`}>
            <AdminItemCard key={item.id} title={item.name} imagePath={item.imagePath} pagePath={item.pagePath}/>
          </NavLink>
        </>)
      })}
    </section>
  );
};