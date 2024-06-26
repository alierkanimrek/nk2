
function carousel_init(className){
    var list = $('.'+className);
    var prev = $('.'+className+"prev")[0];
    var next = $('.'+className+"next")[0];
    var first = null;

    prev.carouselNextButton = next;
    next.carouselPrevButton = prev;

    for (let i = 0; i < list.length; i++) {
        if(i==0){ list[i]["carouselPrev"] = list[list.length-1]; }
        else{ list[i]["carouselPrev"] = list[i-1]; }
        if(i==list.length-1){ list[i]["carouselNext"] = list[0]; }
        else{ list[i]["carouselNext"] = list[i+1]; }
        if(!list[i].classList.contains("is-hidden")){
            first = list[i];
        }
    }
    if(first == null){
        first = list[0];
        first.classList.remove('is-hidden');
        first.classList.add('w3-animate-opacity');
    }
    next.carouselCurrent = first;
    prev.carouselCurrent = first;

}



function carousel_next( e ){
    console.log(e);
    console.log(this);
    var current = e.carouselCurrent;
    var next = e.carouselCurrent.carouselNext;
    var prevButton = e.carouselPrevButton;

    current.classList.add('is-hidden');
    current.classList.remove('w3-animate-opacity');
    next.classList.remove('is-hidden');
    next.classList.add('w3-animate-opacity');

    e.carouselCurrent = next;
    prevButton.carouselCurrent = next;
}


function carousel_prev( e ){
    var current = e.carouselCurrent;
    var prev = e.carouselCurrent.carouselPrev;
    var nextButton = e.carouselNextButton;

    current.classList.add('is-hidden');
    current.classList.remove('w3-animate-opacity');
    prev.classList.remove('is-hidden');
    prev.classList.add('w3-animate-opacity');

    e.carouselCurrent = prev;
    nextButton.carouselCurrent = prev;
}

//carousel_init("car1");
