const num_res=6;



function onResponse(response) {
    console.log('Risposta ricevuta');
    return response.json();
}


function jsonartisti(json){

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

            const img=document.createElement("img");
            img.src=json[i].img;
            container_padre.appendChild(img);
            const txt=document.createElement("h3");
            txt.textContent=json[i].nome;
            container_padre.appendChild(txt);
            const txt_2=document.createElement("span");
            txt_2.textContent='più dettagli';
            txt_2.addEventListener('click',selezionato);
            const desc=document.createElement('p');
            desc.textContent=json[i].descrizione;
            desc.classList.add('hidden');
            container_padre.appendChild(desc);
            container_padre.appendChild(txt_2);
            doc.appendChild(container_padre);
        }
    }
}



function selezionato(event)
{
    const sec =document.querySelector("#modal-view");

    sec.classList.remove("hidden");
    const page=document.querySelector("header");
    page.classList.add("hidden");
    const footer=document.querySelector("footer");
    footer.classList.add("hidden");
    const sec_1=document.querySelector("#contents");
    sec_1.classList.add("hidden");
    const sec_2=document.querySelector("#profile");
    sec_2.classList.add("hidden");
    const nav=document.querySelector("nav");
    nav.classList.add("hidden");
    document.body.classList.add('no-scroll');
    sec.style.top=window.pageYOffset+'px';
    const top=document.querySelector("#top_artist");
    top.classList.add("hidden");
    const div= event.currentTarget.parentNode;
    sec.appendChild(div);
    const par=div.querySelector('span');
    par.textContent='meno Dettagli';
    const desc=div.querySelector('p');
    desc.classList.remove('hidden')
    par.addEventListener('click',deselezionato);
    par.removeEventListener('click',selezionato);


}




function deselezionato(event){
    document.body.classList.remove('no-scroll');
    const sec =document.querySelector("#modal-view");
    sec.classList.add("hidden");
    const div= event.currentTarget.parentNode;
    const desc=div.querySelector('p');
    desc.classList.add('hidden');
    const par=div.querySelector('span');
    par.textContent='più dettagli';
    par.addEventListener('click',selezionato);
    const sec_2=document.querySelector("#contents .X1234 ");
    const top=document.querySelector("#top_artist");
    top.classList.remove("hidden");
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
    sec_2.appendChild(div);
}


function  jsonApi_url(json) {


    if(!json)
    {
        console.log('errore');
    }
    else{
        console.log(json);
        for (let i=0;i<3;i++) {
            const integration = document.querySelectorAll('#top_artist  div iframe');
            integration[i].src = "https://open.spotify.com" + '/embed' + '/track/' + json.tracks[i].id;
        }
    }

}



fetch("fetch_elem.php").then(onResponse).then(jsonartisti);


fetch("ricerca_iframe.php?type=artist").then(onResponse).then(jsonApi_url);