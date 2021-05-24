const num_res=6;

// per fetch
function onResponse(response) {
    console.log('Risposta ricevuta');
    console.log(response);
    return response.json();
}



const search_bar=document.getElementById("X12");
if(search_bar===null){
    console.log('pippo');
}
else{
    search_bar.addEventListener("keyup",ricerca);
}

// per ricerca contenuti con api_spotify
function ricerca(event)
{
    //ottengo ciò che sto scrivendo
    const ele=event.currentTarget.value;
    const txt=encodeURIComponent(ele);
    const sec= document.querySelectorAll('#cont-container1,#cont-container2,#cont-container3');

    fetch("ricerca_contenuti.php?q="+txt+'&type=album').then(onResponse).then(jsonApi);
    fetch("ricerca_contenuti.php?q="+txt+'&type=track').then(onResponse).then(jsonApi_2);
    fetch("ricerca_contenuti.php?q="+txt+'&type=artist').then(onResponse).then(jsonApi_3);






    if(ele==='')
    {
        for (el of sec){
            el.classList.add('hidden');
        }
    }else {
        for (el of sec) {
            el.classList.remove('hidden');
        }

    }

}

//aggiungo gli elementi nelle varie sezioni di ricerca
function jsonApi(json){

    if(!json)
    {
        console.log('errore');
    }else{
        console.log(json);
        const doc=document.querySelector(" #cont-container1 .X1234");
        doc.innerHTML='';
        for(let i=0;i<num_res;i++)
        {
            const container=document.createElement("div");
            const img_2=document.createElement("img");

            const img=document.createElement("img");
            img.src=json.albums.items[i].images[1].url;
            container.appendChild(img);

            const txt=document.createElement("h3");
            txt.textContent=json.albums.items[i].artists[0].name;
            container.appendChild(txt);
            img_2.classList.add('preferiti_2');
            img_2.src='preferiti.png';
            container.appendChild(img_2);
            img_2.addEventListener('click',selectedItem);
            doc.appendChild(container);
        }
    }
}


function jsonApi_2(json){

    if(!json)
    {
        console.log('errore');
    }else{
        console.log(json);
        const doc=document.querySelector(" #cont-container2 .X1234");
        doc.innerHTML='';
        for(let i=0;i<num_res;i++)
        {
            const container=document.createElement("div")


            const img=document.createElement("img");
            img.src=json.tracks.items[i].album.images[1].url;
            container.appendChild(img);

            const txt=document.createElement("h3");
            txt.textContent=json.tracks.items[i].name;

            container.appendChild(txt);
            const img_2=document.createElement("img");
            img_2.classList.add('preferiti_2');
            container.appendChild(img_2);
            img_2.src='preferiti.png';
            img_2.addEventListener('click',selectedItem);
            doc.appendChild(container);
        }
    }
}
function jsonApi_3(json){

    if(!json)
    {
        console.log('errore');
    }else{
        console.log(json);
        const doc=document.querySelector(" #cont-container3 .X1234");
        doc.innerHTML='';
        for(let i=0;i<num_res;i++)
        {
            const container=document.createElement("div");

            const img=document.createElement("img");
            img.src=json.artists.items[i].images[1].url;
            container.appendChild(img);

            const txt=document.createElement("h3");
            txt.textContent=json.artists.items[i].name;
            container.appendChild(txt);
            const img_2=document.createElement("img");
            img_2.classList.add('preferiti_2');

            container.appendChild(img_2);
            img_2.src='preferiti.png';
            img_2.addEventListener('click',selectedItem);
            doc.appendChild(container);
        }
    }
}

//inserimento dei preferiti nel db e append child al primo tocco per evitare il ricaricamento della pagina
function selectedItem(event)
{
    const item=event.currentTarget.parentNode.parentNode.parentNode;
    const item_2=event.currentTarget.parentNode;
    const elem= item_2.querySelector('h3');
    const elem_text=encodeURIComponent(elem.textContent);
    const img_1 =item_2.querySelector('img');
    const img_url=encodeURIComponent(img_1.src);

    let type;
    let t;

    if(item.id==='cont-container1') {
        t = 'album';
        type = encodeURIComponent(t);

        const det = document.querySelector("#container1 .X1234 ");
        fetch('insert.php?title=' + elem_text + '&immagine=' + img_url + '&type=' + type).then(onResponse).then(onjson);
        if(!checkIsFavourite(elem.textContent,img_1.src)) {
            const img = item_2.querySelectorAll('img');
            img[1].src = 'minus_b.png';
            img[1].addEventListener('click', remove_element);
            det.appendChild(item_2);
        }else
        {
            const span_1=document.createElement('span');
            span_1.textContent='elemento duplicato';
            item_2.appendChild(span_1);
            item_2.removeChild(span_1);


        }


    }

    if(item.id==='cont-container2') {
        t = 'track';
        type = encodeURIComponent(t);

        const det = document.querySelector("#container2 .X1234 ");
        fetch('insert.php?title=' + elem_text + '&immagine=' + img_url + '&type=' + type).then(onResponse).then(onjson);
        if(!checkIsFavourite(elem.textContent,img_1.src)) {

            const img = item_2.querySelectorAll('img');
            img[1].src = 'minus_b.png';
            img[1].addEventListener('click', remove_element);
            det.appendChild(item_2);
        }else
        {
            const span_1=document.createElement('span');
            span_1.textContent='elemento duplicato';
            item_2.appendChild(span_1);
            item_2.removeChild(span_1);
        }

    }
    if(item.id==='cont-container3') {
        t = 'artist';
        type = encodeURIComponent(t);
        fetch('insert.php?title=' + elem_text + '&immagine=' + img_url + '&type=' + type).then(onResponse).then(onjson);
        const det = document.querySelector("#container3 .X1234 ");
        if(!checkIsFavourite(elem.textContent,img_1.src)) {

            const img = item_2.querySelectorAll('img');
            img[1].src = 'minus_b.png';
            img[1].addEventListener('click', remove_element);
            det.appendChild(item_2);
        }else
        {
            const span_1=document.createElement('span');
            span_1.textContent='elemento duplicato';
            item_2.appendChild(span_1);
            item_2.removeChild(span_1);
        }

    }

}



//verifico la presenza di un preferito
function checkIsFavourite(title,url){

    /*Questa funzione verifica se l'utente ha quel preferito*/

    const favourites = document.querySelectorAll(" #container2  .X1234 div,#container1 .X1234 div,#container3 .X1234 div");

    for(myfavourite of  favourites){

        if(myfavourite.querySelector("h3").textContent === title && (myfavourite.querySelector("img").src === url))
        {
            return true;
        }

    }

    return false;

}








function onjson(json)
{
    if(!json)
    {
        console.log('errore');
    }
    else{
       console.log(json);

    }
}










function onjsondb(json) {
    if (!json) {
        console.log('errore');
    }
    else {
        console.log(json);

        for (let i = 0; i < json.length; i++) {
            switch (json[i].tipo){
                case 'album':
                {
                    album(json[i]);
                    break;
                }
                case 'track':
                {
                    tracks(json[i]);
                    break
                }
                case 'artist':
                {
                    artist(json[i]);
                    break;
                }
            }

        }
    }

}

//fetch contenutidal db


fetch('fetch_elem_db.php').then(onResponse).then(onjsondb);



function artist(json)
{
        if(!checkIsFavourite(json.title,json.img.src)){


        const sec = document.querySelector('#container3 .X1234');

        const container = document.createElement("div");

        const img = document.createElement("img");
        img.src = json.img;
        container.appendChild(img);

        const txt = document.createElement("h3");
        txt.textContent = json.title;
        container.appendChild(txt);
        const img_2 = document.createElement("img");
        img_2.src = 'minus_b.png';

        // per eventuale rimozione del preferito
        //prendo tutti gli elementi nella section dei preferiti

        img_2.classList.add('preferiti_');
        img_2.addEventListener('click', remove_element);
        container.appendChild(img_2);
        sec.appendChild(container);
        }
}


function album(json)
{
         if(!checkIsFavourite(json.title,json.img.src)) {
             const sec = document.querySelector('#container1 .X1234');

             const container = document.createElement("div");

             const img = document.createElement("img");
             img.src = json.img;
             container.appendChild(img);

             const txt = document.createElement("h3");
             txt.textContent = json.title;
             container.appendChild(txt);

             const img_2 = document.createElement("img");
             img_2.src = 'minus_b.png';
             img_2.classList.add('preferiti_');
             img_2.addEventListener('click', remove_element);

             container.appendChild(img_2);
             sec.appendChild(container);
         }

}

function tracks(json)
{

        if(!checkIsFavourite(json.title,json.img.src)) {
            const sec = document.querySelector('#container2 .X1234');

            const container = document.createElement("div");

            const img = document.createElement("img");
            img.src = json.img;
            container.appendChild(img);

            const txt = document.createElement("h3");
            txt.textContent = json.title;
            container.appendChild(txt);
            const img_2 = document.createElement("img");
            img_2.src = 'minus_b.png';
            img_2.classList.add('preferiti_');
            img_2.addEventListener('click', remove_element);

            container.appendChild(img_2);
            sec.appendChild(container);
        }

}




//rimuove un elemento dai preferiti

            function remove_element(event){



                const button_div = event.currentTarget.parentNode;
                const div_h3=button_div.querySelector('h3');
                const title=encodeURIComponent(div_h3.textContent);
                button_div.remove();

                fetch("rimozione_preferiti.php?title="+title).then(onResponse)
                    .then(onjson);


            }



// ricerca testi
function onjson_testi(json)
{
    if(!json)
    {
        console.log('errore');
    }
    else{
        console.log(json);
        const sec_testo =document.querySelector('#testo');
        const div_text=document.createElement('div');
        const text=document.createElement('p');
        text.textContent=json.lyrics;
        sec_testo.appendChild(div_text);
        div_text.appendChild(text);

    }
}





const  testi=document.querySelector('#invio');
            testi.addEventListener('click',getLyrics);



            function getLyrics(event){

                    const form=document.querySelector('form');
                    const title=form.titolo.value;
                    console.log(title);
                    const artista=form.artista.value;
                    console.log(artista);
                    const titolo=document.createElement('h2');
                    titolo.textContent=title;
                    const container=document.querySelector('#testo');
                    container.appendChild(titolo);
                    fetch("ricerca_testi.php?titolo="+encodeURIComponent(title)+'&artista='+encodeURIComponent(artista)).then(onResponse).then(onjson_testi);
                    fetch("ricerca_iframe.php?q="+encodeURIComponent(title)+'&artist='+encodeURIComponent(artista)+'&type=track').then(onResponse).then(jsonApi_url);
                    const integration= document.querySelector('#lyrics iframe');
                    integration.classList.remove('hidden');
                    const span=document.createElement('span');
                    span.textContent='Fai doppio click sul pulsante per cercare una nuova canzone';
                    form.appendChild(span);
                    event.currentTarget.addEventListener('click',refresh);
                    event.currentTarget.removeEventListener('click',getLyrics);

            }



function refresh(event){
    const sec=document.querySelector('#testo');
    sec.innerHTML='';
    const container=document.querySelector('form span');
    container.remove();
    const integration= document.querySelector('#lyrics iframe');
    integration.classList.add('hidden');
    integration.src="";
    event.currentTarget.addEventListener('click',getLyrics);
    event.currentTarget.removeEventListener('click',refresh);

}



function jsonApi_url(json)
{

    if(!json)
    {
        console.log('errore');
    }
    else{
        console.log(json);
        const integration= document.querySelector('#lyrics iframe');
        integration.src="https://open.spotify.com"+'/embed'+'/track/'+json.tracks.items[0].id;

    }


}