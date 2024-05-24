
let dati
let userDati
var indexSpawn = 1
var indexMax
var newLang = {}

window.addEventListener('message', function (e) {
    if (e.data.action === "infoPg") {
        newLang = e.data.lang
        $('.charsel-title').text(newLang.char_selction)
        $('.selectpg-btn').text(newLang.select_pg)
        $('.gender').text(newLang.gender)
        $('.date').text(newLang.date)
        $('.money-txt').text(newLang.money)
        $('.bank-txt').text(newLang.bank)
        $('.played-time').text(newLang.played_time)
        $('.create-char').text(newLang.create_char)
        $('.male').text(newLang.male)
        $('.female').text(newLang.female)
        $('.create-text').text(newLang.create)
        OpenMulticharacter(e.data.data)
    } else if (e.data.action === "spawnSelector") {
        $('body').css('display', 'flex');
        $('.spawn').css('display', 'flex');
        $('.last-pos').css('display', 'flex');
        $('.last-pos').text(newLang.last_position)
        $('.spawn-txt').text(newLang.spawn)
        indexMax = e.data.numeroMax
        if (e.data.isNew === true) {
            $('.last-pos').css('display', 'none');
        }
    } else if (e.data.action === "openPannel") {
        newLang = e.data.lang
        $('.back-text').text(newLang.back)
        $('.setpg-text').text(newLang.set_pg)
        $('.confirm').text(newLang.confirm)
        OpenPannel(e.data.users)
    }
})

function OpenMulticharacter(data) {
    dati = data
    $('body').css('display', 'flex');
    $('.login').css('display', 'flex');

    $(".lista-perssonaggi").empty();

    for (const nzy in data) {
        let listaPg = ``
        if (data[nzy].info) {
            if (data[nzy].info.disabled === false) {
                listaPg = `
                <div  onclick="DatiPg(${nzy})"  class="${nzy} cursor-pointer hover:bg-[#16161b] border-b-[0.2vh] border-[#1b1b22] h-[6vh] w-[100%] bg-[#1b1b22] rounded-[1vh] flex justify-between shrink-0">
                    <div class="h-[100%] w-auto flex justify-start items-center gap-[1vh]">
                        <div class="ml-[1.5vh] h-[3vh] w-[3vh] rounded-[100%] bg-[#d0905f] flex items-center justify-center">
                            <i class="text-[#111116] text-[1.8vh] fa-solid fa-user"></i>
                        </div>
                        <div class="h-[80%] w-auto flex flex-col justify-center items-start">
                            <h1 class="nome text-white text-[1.8vh] font-[500]" >${data[nzy].info.firstName} ${data[nzy].info.lastname}</h1>
                            <h2 class="text-[#99999b] text-[1.2vh] font-[600]" >${data[nzy].info.job}</h2>
                        </div>
                    </div>
                    <div class="h-[100%] w-auto flex justify-center items-center">
                        <i class="text-white text-[1.5vh] hover:text-[#d0905f] fa-solid fa-play mr-[1vh]"></i>
                    </div>
                </div>
                `
            } else {
                listaPg = `
            <div class="${nzy} opacity-75 cursor-pointer hover:bg-[#16161b] border-b-[0.2vh] border-[#1b1b22] h-[6vh] w-[100%] bg-[#1b1b22] rounded-[1vh] flex justify-between shrink-0">
                <div class="h-[100%] w-auto flex justify-start items-center gap-[1vh]">
                    <div class="ml-[1.5vh] h-[3vh] w-[3vh] rounded-[100%] bg-[#d0905f] flex items-center justify-center">
                        <i class="text-[#111116] text-[1.8vh] fa-solid fa-user"></i>
                    </div>
                    <div class="h-[80%] w-auto flex flex-col justify-center items-start">
                        <h1 class="nome text-white text-[1.8vh] font-[500]" >${data[nzy].info.firstName} ${data[nzy].info.lastname}</h1>
                        <h2 class="text-[#99999b] text-[1.2vh] font-[600]" >${newLang.pg_disabled}</h2>
                    </div>
                </div>
                <div class="h-[100%] w-auto flex justify-center items-center">
                    <i class="text-white text-[1.5vh] hover:text-[#d0905f] mr-[1vh] fa-solid fa-lock"></i>
                </div>
            </div>
            `
            }
        } else {
            listaPg = `
            <div onclick="createPg(${nzy})" class="${nzy} cursor-pointer hover:bg-[#16161b] h-[6vh] w-[100%] bg-[#1b1b22] opacity-60 rounded-[1vh] flex justify-between shrink-0">
                <div class="h-[100%] w-auto flex justify-start items-center gap-[1vh]">
                    <div class="ml-[1.5vh] h-[3vh] w-[3vh] rounded-[100%] bg-[#d0905f] flex items-center justify-center">
                        <i class="text-[#111116] text-[1.8vh] fa-solid fa-user"></i>
                    </div>
                    <div class="h-[80%] w-auto flex flex-col justify-center items-start">
                        <h1 class="text-[#99999b] text-[1.8vh] font-[500]" >${newLang.new_slot}</h1>
                        <h2 class="text-[#99999b] text-[1.2vh] font-[600]" >${newLang.create_new_char}</h2>
                    </div>
                </div>
                <div class="h-[100%] w-auto flex justify-center items-center">
                    <i class="text-[#99999b] font-bold text-[1.8vh] fa-solid fa-plus mr-[1vh]"></i>
                </div>
            </div>
            `
        }
        $(".lista-perssonaggi").append(listaPg);
    }
}

function DatiPg(nzy) {
    newDati = dati[nzy].info
    $('.creaPg').css('display', 'none');
    $('.info-pg').css('display', 'flex');
    $('.select').css('display', 'flex');
    $('.nome-pl').text(newDati.firstName + ' ' + newDati.lastname)
    $('.sesso-bello').text(newDati.sex === 'm' ? 'Male' : 'Female')
    $('.data').text(newDati.dob)
    $('.money').text(newDati.money + ' $')
    $('.bank').text(newDati.bank + ' $')

    if (newDati.time >= 60) {
        const hours = Math.floor(newDati.time / 60);
        const minutes = newDati.time % 60;

        if (minutes === 0) {
            $('.online').text(hours + ' hour');
        } else {
            $('.online').text(hours + ' hour ' + minutes + ' min');
        }
    } else {
        $('.online').text(newDati.time + ' min');
    }

    $.post('https://ars_login/action', JSON.stringify({
        tipo: 'changeChar',
        slot: nzy + 1
    }))
}


$('.select').on('click', function (e) {
    $('body').css('display', 'none');
    $('.login').css('display', 'none');
    $('.info-pg').css('display', 'none');
    $('.select').css('display', 'none');
    $.post('https://ars_login/action', JSON.stringify({
        tipo: 'selectCharacter',
        slot: newDati.slot
    }))
})

$('.create-btn').on('click', function (e) {
    let nome = $('.nome-input').val()
    let cognome = $('.cognome-input').val()
    let data = dataModifica($('.data-input').val())
    let sexxo = $('select').val()
    let altezza = $('.altezza-input').val()
    $('.nome-input').val('')
    $('.cognome-input').val('')
    $('.data-input').val('')
    $('.altezza-input').val('')


    if (nome !== '' && nome.length > 2 && cognome !== '' && cognome.length > 2 && data !== '' && altezza !== '') {
        console.log(nome, cognome, data, sexxo)
        $.post('https://ars_login/action', JSON.stringify({
            tipo: 'createChar',
            nome: nome,
            cognome: cognome,
            data: data,
            sex: sexxo,
            altezza: altezza
        }))
        $('body').css('display', 'none');
        $('.login').css('display', 'none');
        $('.creaPg').css('display', 'none');
    } else {
        console.log('compila negro di merda bastrardo del cazzo')
    }

})


const changeSpawnPoint = (direction) => {
    if ((direction === "forward" && indexSpawn < indexMax) || (direction === "backward" && indexSpawn > 1)) {
        indexSpawn = (direction === "forward") ? indexSpawn + 1 : indexSpawn - 1;
        $.post('https://ars_login/action', JSON.stringify({
            tipo: 'changeSpawnPoint',
            index: indexSpawn
        }), (label) => {
            $('.spawn-label').text(label);
        });
    }
}

$('.ind').on('click', () => {
    changeSpawnPoint("backward");
});

$('.ava').on('click', () => {
    changeSpawnPoint("forward");
});


$('.spawn-btn').on('click', function (e) {
    $('body').css('display', 'none');
    $('.spawn').css('display', 'none');
    $.post('https://ars_login/action', JSON.stringify({
        tipo: 'selectSpawnPoint',
        index: indexSpawn
    }), function (label) {
        $('.spawn-label').text(label)
    })
    indexSpawn = 1
})

$('.last-pos').on('click', function (e) {
    $('body').css('display', 'none');
    $('.spawn').css('display', 'none');
    $.post('https://ars_login/action', JSON.stringify({
        tipo: 'spawnLast',
    }), function (label) {
        $('.spawn-label').text(label)
    })
    indexSpawn = 1
})



function createPg(idPg) {
    $('.select').css('display', 'none');
    $('.info-pg').css('display', 'none');
    $('.creaPg').css('display', 'flex');
    $.post('https://ars_login/action', JSON.stringify({
        tipo: 'emptyChar',
        idPg: idPg
    }))
}


function dataModifica(data) {
    let [anno, mese, g] = data.split('-')
    return `${mese}/${g}/${anno}`
}

function HeightLimited(input, maxValue) {
    if (input.value !== "") {
        const inputValue = parseInt(input.value, 10);
        if (inputValue > maxValue) {
            input.value = maxValue;
        }
    }
}
pannelOpen = false

function OpenPannel(users) {
    userDati = users
    pannelOpen = true
    $('body').css('display', 'flex');
    $('.pannel').fadeIn();
    $('.users').fadeIn();

    $(".users").empty();

    for (const nzy in users) {
        let colorOnline = "#d0905f"
        let textOnline = "ONLINE"
        console.log(users[nzy].online)
        if (users[nzy].online === false) {
            colorOnline = "#BD1B1A"
            textOnline = "OFFLINE"
        }
        listaUser = ``
        listaUser = `
            <section
            class="w-[96%] h-[5vh] bg-[#2f2e33] rounded-[0.4vh] flex items-center justify-between shrink-0">
            <div class="ml-[1vh] h-[100%] min-w-[60%] w-auto flex justify-between items-center gap-[2vh]">
                <div class="h-[70%] w-[10vh] bg-[${colorOnline}] rounded-[0.5vh] flex justify-center items-center">
                    <h1 class="text-[1.6vh] text-white font-[600]">${textOnline}</h1>
                </div>
                <p class="text-[1.9vh] text-white font-[500]">${users[nzy].steam}</p>
                <p onclick="Copia(this)" class=" text-[#959399] cursor-pointer text-[1.4vh] blur-[0.3vh] hover:blur-none">${users[nzy].ide}</p>
            </div>
            <div class="h-[100%] flex justify-start items-center">
                <div onclick="OpenSetPg(${nzy})"
                    class="mr-[1vh] h-[70%] w-auto bg-[#5c5a61] cursor-pointer hover:bg-[#413f44] pl-[1.5vh] pr-[1.5vh] rounded-[0.5vh] flex justify-center items-center">
                    <h1 class="text-white text-[1.6vh] font-[600]">SET</h1>
                </div>
                <div onclick="OpenPgList(${nzy})"
                    class="mr-[1vh] h-[70%] w-auto bg-[#5c5a61] cursor-pointer hover:bg-[#413f44] pl-[1.5vh] pr-[1.5vh] rounded-[0.5vh] flex justify-center items-center">
                    <h1 class="text-white text-[1.6vh] font-[600]">INFO</h1>
                </div>
            </div>
            </section>
        `
        $(".users").append(listaUser);
    }
}

function Copia(t) {
    const TestoDaCopiare = $(t).text()
    const tempInput = document.createElement('input');
    document.body.appendChild(tempInput);
    tempInput.value = TestoDaCopiare;
    tempInput.select()
    document.execCommand('copy')
    document.body.removeChild(tempInput)
}

function OpenPgList(index) {
    $.post('https://ars_login/action', JSON.stringify({
        tipo: 'charactersList',
        ide: userDati[index].ide
    }), function (data) {
        $('.users').fadeOut();
        setTimeout(() => {
            OpenPgListHtml(data)
        }, 400)
    })
}

function OpenPgListHtml(pg) {
    pgDati = pg
    $('.pg-list').fadeIn();
    $('.back').fadeIn();

    $(".pg-list").empty();

    for (const nzy in pg) {
        let sexxoItaliano
        let status
        if (pg[nzy].sex === "m") {
            sexxoItaliano = "male"
        } else {
            sexxoItaliano = "female"
        }
        if (pg[nzy].disabled === true) {
            status = newLang.enable
            statusColor = "#157F3F"
            statusHoverColor = "#1e663b"
        } else {
            status = newLang.disable
            statusColor = "#BD1B1A"
            statusHoverColor = "#911413"

        }
        listaPg = ``
        listaPg = `
        <section class="w-[96%] h-[5vh] bg-[#2f2e33] rounded-[0.4vh] flex items-center justify-between shrink-0">
        <div class="ml-[1vh] h-[100%]  flex justify-start items-center gap-[2vh]">
            <div
                class="h-[70%] w-auto bg-[#5c5a61] pl-[1vh] pr-[1vh]  rounded-[0.5vh] flex justify-center items-center">
                <h1 class="text-[1.6vh] text-white font-[600]">#${pg[nzy].slot}</h1>
            </div>
            <p class="text-[1.9vh] text-white font-[500]">${pg[nzy].firstName + ' ' + pg[nzy].lastName}</p>
            <p class="text-[1.4vh] text-[#959399] font-bold"><i
                    class="text-[#d0905f] fa-solid fa-calendar-days"></i> ${pg[nzy].dob}</p>
            <p class="text-[1.4vh] text-[#959399] font-bold uppercase"><i
                    class="text-[#d0905f] fa-solid fa-venus"></i> ${sexxoItaliano}</p>
            <p class="text-[1.4vh] text-[#959399] font-bold uppercase"><i
                    class="text-[#d0905f] fa-solid fa-person"></i> ${pg[nzy].height} CM</p>
            <p class="text-[1.4vh] text-[#959399] font-bold uppercase"><i
                    class="text-[#d0905f] fa-solid fa-coins"></i> ${pg[nzy].money} $</p>
            <p class="text-[1.4vh] text-[#959399] font-bold uppercase"><i
                    class="text-[#d0905f] fa-solid fa-landmark"></i> ${pg[nzy].bank} $</p>
        </div>
        <div class="h-[100%] flex justify-start items-center">
            <div onclick="ChangeStatusPg('${status}', '${nzy}')"
                class="mr-[1vh] h-[3vh] w-[10vh] bg-[${statusColor}] cursor-pointer hover:bg-[${statusHoverColor}] pl-[1.5vh] pr-[1.5vh] rounded-[0.5vh] flex justify-center items-center">
                <h1 class="text-white text-[1.6vh] font-[600]">${status}</h1>
            </div>
            <div onclick="DeletePg('${nzy}')"
                class="mr-[1vh] h-[3vh]  w-[3vh]  bg-[#5c5a61] cursor-pointer hover:bg-[#413f44] pl-[1.5vh] pr-[1.5vh] rounded-[0.5vh] flex justify-center items-center">
                <i class=" text-white text-[1.6vh] fa-solid fa-trash-can"></i>
            </div>
        </div>
        </section>
        `
        $(".pg-list").append(listaPg);
    }
}

function ChangeStatusPg(status, license) {
    $.post('https://ars_login/action', JSON.stringify({
        tipo: 'changeStatus',
        status: status,
        license: license
    }), function (data) {
        OpenPgListHtml(data)
    })
}

function DeletePg(license) {
    $.post('https://ars_login/action', JSON.stringify({
        tipo: 'deleteCharacter',
        license: license
    }), function (data) {
        OpenPgListHtml(data)
    })
}


$('.back').on('click', function (e) {
    $('.pg-list').fadeOut();
    $('.back').fadeOut();
    setTimeout(() => {
        OpenPannel(userDati)
    }, 400)
})

let changeIde
let inputChangePg = false

function OpenSetPg(index) {
    inputChangePg = true
    changeIde = userDati[index].ide
    $('.pannel').addClass("blur-sm")
    $('.setPg').fadeIn()
}

let indexPg = 1

$('.rempg').on('click', function (e) {
    if (indexPg > 1) {
        indexPg = indexPg - 1
        $('.index-pg').text(indexPg)
    }
})

$('.addpg').on('click', function (e) {
    indexPg = indexPg + 1
    $('.index-pg').text(indexPg)
})

$('.conferma-pg').on('click', function (e) {
    $('.pannel').removeClass("blur-sm")
    $('.setPg').fadeOut()
    inputChangePg = false
    $.post('https://ars_login/action', JSON.stringify({
        tipo: 'updateSots',
        slots: $('.index-pg').text(),
        license: changeIde
    }))
    $('.index-pg').text('1')
})


$(document).keyup(function (e) {
    if (e.key === 'Escape') {
        if (inputChangePg === true) {
            $('.pannel').removeClass("blur-sm")
            $('.setPg').fadeOut()
            inputChangePg = false
        } else if (pannelOpen === true) {
            $('.pannel').fadeOut();
            $('.back').fadeOut();
            $('.pg-list').fadeOut();
            $('.users').fadeOut();
            $.post("https://ars_login/action", JSON.stringify({
                tipo: "close",
            }));
        }
    }
})