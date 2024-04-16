import React from "react";
import AdminItemCard from "../components/items/adminItemCard/AdminItemCard";
import addDuaImg from "../../src/assets/images/man_praying_v1.png"
import { NavLink } from "react-router-dom";

export const Services = () => {
  let arr =[
    {
      "id":1,
      "name": "Verses",
      "imagePath":addDuaImg,
      "pagePath":"/verses"
    },
    {
      "id":2,
      "name": "Add Hadith",
      "imagePath":addDuaImg,
      "pagePath":"/hadiths"
    },
    {
      "id":3,
      "name": "Add Dua",
      "imagePath":addDuaImg,
      "pagePath":"/add-dua"
    },
    {
      "id":4,
      "name": "Surahs",
      "imagePath":addDuaImg,
      "pagePath":"/surahs"
    },
    {
      "id":4,
      "name": "Ontologies",
      "imagePath":addDuaImg,
      "pagePath":"/ontologies"
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