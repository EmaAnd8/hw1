const num_res=6;



function onResponse(response) {
    console.log('Risposta ricevuta');
    return response.json();
}






function selezionato(event)
{
    const div= event.currentTarget.parentNode;

    const more=div.querySelector('p');
    div.removeChild(more);

    fetch("fetch_album_2.php?codice="+encodeURIComponent(div.querySelector('span').textContent)).then(onResponse).then(jsonalbum_2);

    const page=document.querySelector("header");
    page.classList.add("hidden");
    const footer=document.querySelector("footer");
    footer.classList.add("hidden");
    const sec_1=document.querySelector("#contents");
    sec_1.classList.add("hidden");
    const nav=document.querySelector("nav");
    nav.classList.add("hidden");
    document.body.classList.add('no-scroll');


    const sec_2=document.querySelector("#profile");
    sec_2.classList.add("hidden");
    const top=document.querySelector("#top_album");
    top.classList.add("hidden");
    const par=document.createElement('p');
    par.textContent='meno Dettagli';
    div.appendChild(par);
    const sec =document.querySelector("#modal-view");
    sec.classList.remove("hidden");
    sec.style.top=window.pageYOffset+'px';
    sec.appendChild(div);
    par.addEventListener('click',deselezionato);
    par.removeEventListener('click',selezionato);


}




function deselezionato(event){

    document.body.classList.remove('no-scroll');
    const sec =document.querySelector("#modal-view");
    sec.innerHTML='';
    const div= event.currentTarget.parentNode;
    const par=div.querySelector('p');
    par.textContent='più Dettagli';
    par.addEventListener('click',selezionato);

    sec.classList.add("hidden");
    const top=document.querySelector("#top_album");
    top.classList.remove("hidden");
    const d_father=document.createElement('div');
    const span=div.querySelector('span');
    span.classList.add('hidden')
    d_father.appendChild(span);
    const el=div.querySelector('img');
    d_father.appendChild(el);
    const el_2=div.querySelector('h3');
    d_father.appendChild(el_2);

    d_father.appendChild(par);

    div.remove();


    const sec_2=document.querySelector("#contents .X1234 ");

    const page=document.querySelector("header");
    page.classList.remove("hidden");
    const footer=document.querySelector("footer");
    footer.classList.remove("hidden");
    const sec_1=document.querySelector("#contents ");
    sec_1.classList.remove("hidden");
    const sec_3=document.querySelector("#profile");
    sec_3.classList.remove("hidden");
    const nav=document.querySelector("nav");
    nav.classList.remove("hidden");
    sec_2.appendChild(d_father);
}



function jsonalbum(json){

    if(!json)
    {
        console.log('errore');
    }else{
        console.log(json);
        const doc=document.querySelector(".X1234");
        doc.innerHTML='';
        for(let i=0;i<num_res;i++)
        {
            const container_padre=document.createElement("div");



            const cod=document.createElement("span");
            cod.textContent=json[i].codice;
            cod.classList.add('hidden');
            container_padre.appendChild(cod);

            const img=document.createElement("img");
            img.src=json[i].copertina;
            container_padre.appendChild(img);
            const txt=document.createElement("h3");
            txt.textContent=json[i].nome;
            container_padre.appendChild(txt);

            const testo=document.createElement("p");
            testo.textContent="più dettagli"
            testo.addEventListener('click',selezionato);
            container_padre.appendChild(testo);
            doc.appendChild(container_padre);
        }
    }
}



function jsonalbum_2(json) {

    if (!json) {
        console.log('errore');
    } else {
        console.log(json);
        const sec =document.querySelector("#modal-view div");
        const  h4=document.createElement('h4');
        h4.textContent='Brani';
        sec.appendChild(h4);
        for(let i=0;i<json.length;i++)
        {
            const  p=document.createElement('p');
            p.textContent=json[i].brano;
            sec.appendChild(p)
        }



    }



}




function  jsonApi_url(json) {


    if(!json)
    {
        console.log('errore');
    }
    else{
        console.log(json);
        for (let i=0;i<3;i++) {
            const integration = document.querySelectorAll('#top_album  div iframe');
            integration[i].src = "https://open.spotify.com" + '/embed' + '/album/' + json.albums.items[i].id;
        }
    }

}

fetch("fetch_album.php").then(onResponse).then(jsonalbum);

fetch("ricerca_iframe.php?type=album").then(onResponse).then(jsonApi_url);

