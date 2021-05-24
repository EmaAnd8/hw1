-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 24, 2021 alle 20:58
-- Versione del server: 10.4.18-MariaDB
-- Versione PHP: 8.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hw1_1`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `album`
--

CREATE TABLE `album` (
  `codice` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `genere` varchar(20) DEFAULT NULL,
  `numero_brani` int(11) DEFAULT NULL,
  `copertina` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `album`
--

INSERT INTO `album` (`codice`, `nome`, `genere`, `numero_brani`, `copertina`) VALUES
(1, 'Tre Ruote', 'Rock', 2, 'https://i.scdn.co/image/ab67616d00001e0211855d01a9cbba0c786b9711'),
(2, 'Total Destruction', 'Rock', 1, 'https://i.scdn.co/image/ab67616d00001e024f6b8cfff66f705c4e58db55'),
(3, 'Live is life', 'Pop', 2, 'https://i.scdn.co/image/ab67616d00001e02680c56a0f621a43edf19046a'),
(4, 'Live4money', 'Rap', 1, 'https://i.scdn.co/image/ab67616d00001e02e9e418891c230de13bee51e4'),
(5, 'Xelix', 'Pop', 3, 'https://i.scdn.co/image/ab67616d00001e0225fb7c7bb14b3a56fdd626d8'),
(6, 'why i have to do this?', 'rock', 4, 'https://i.scdn.co/image/ab67616d00001e02a70af97357ff1910173cc084');

--
-- Trigger `album`
--
DELIMITER $$
CREATE TRIGGER `numero_brani` BEFORE INSERT ON `album` FOR EACH ROW begin
DECLARE errorMessage VARCHAR(255);
set errorMessage='non puoi inserire più di venti brani,ATTENZIONE!!!';
if new.numero_brani>20
then
signal sqlstate  '45000'
SET MESSAGE_TEXT = errorMessage;
end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `artista`
--

CREATE TABLE `artista` (
  `ID` int(11) NOT NULL,
  `nome` varchar(20) DEFAULT NULL,
  `inizio_carriera` date DEFAULT NULL,
  `numero_partecipanti` int(11) DEFAULT NULL,
  `profilo` varchar(500) NOT NULL,
  `descrizione` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `artista`
--

INSERT INTO `artista` (`ID`, `nome`, `inizio_carriera`, `numero_partecipanti`, `profilo`, `descrizione`) VALUES
(1, 'Fedez', '2006-08-10', 1, 'https://i.scdn.co/image/33eff36d8b3aed513dbd27524ac68aa86cc47801', 'Fedez è nato a Milano il 15 ottobre 1989 ma è cresciuto a Buccinasco. La sua famiglia è originaria di Castel Lagopesole, in provincia di Potenza, e ha dichiarato che tra i suoi avi figura il brigante Ninco Nanco. Durante l\'adolescenza ha frequentato il liceo artistico, abbandonando tuttavia gli studi al quarto anno per focalizzarsi sulla musica.'),
(2, 'Muse', '1994-10-11', 3, 'https://i.scdn.co/image/17f00ec7613d733f2dd88de8f2c1628ea5f9adde', 'I Muse sono un gruppo musicale rock alternativo britannico formatosi nel 1992 a Teignmouth, nel Devon.Sono riconosciuti per uno stile musicale molto eclettico che raccoglie influenze di più generi come elettronica, rock progressivo, spesso segnati da una vena sinfonica e orchestrale. La maggior parte dei testi delle loro canzoni, composte principalmente dal frontman Matthew Bellamy, trattano temi riguardanti apocalisse, UFO, guerra, vita, universo, politica e religione.'),
(3, 'J Balvin', '2004-11-05', 1, 'https://i.scdn.co/image/a0549453d385c05466001765b2503a502601894e', 'J Balvin, pseudonimo di José Álvaro Osorio Balvin (Medellín, 7 maggio 1985), è un cantante e produttore discografico colombiano.Nominato due volte anche ai Grammy Award, tra cui nella categoria Record of the Year per il brano I Like It., è stato riconosciuto con numerosi premi, tra cui 5 Billboard Latin Music Award, 4 Latin Grammy Awards, 3 MTV Video Music Awards. Dall\'inizio della sua carriera ha venduto oltre 35 milioni di singoli e 4 milioni di album globalmente.I suoi brani sono perlopiù reggaeton, ma spesso influenzati da sonorità tipicamente hip hop e R&B. Ha lavorato con numerosi artisti latinoamericani tra cui Sean Paul, Pitbull, Bad Bunny, Camila Cabello, Ozuna, Nicky Jam, Maluma e Alejandro Sanz. Nel corso della sua carriera ha introdotto la musica in lingua spagnola ad un pubblico globale, anche collaborando con artisti anglofoni come Beyoncé, Pharrell Williams, The Black Eyed Peas, Cardi B e Major Lazer, o francofoni come David Guetta e Willy William.'),
(4, 'Ruelle', '2010-10-24', 1, 'https://i.scdn.co/image/7ebc5768cc1ccde497eae33125d39831329bb7e5', 'Sebbene Nashville sia meglio conosciuta per la sua musica country e rock-and-roll, i primi due album di Margaret, For What It\'s Worth del 2010 e Show and Tell del 2012, di genere indie pop, sono stati rilasciati con il suo nome di nascita. Ha poi adottato il nome Ruelle per rappresentare un cambiamento nel genere spostandosi verso l\'elettropop con uno stile dark e cinematografico come negli EP, Up in Flames del 2015  Madness del 2016 , e Rival del 2017.Oltre alle citate sigle per Shadowhunters e The Shannara Chronicles, altre suoi braini sono apparsi in numerose serie televisive come, Arrow, Dancing with the Stars, The Challenge XXX: Dirty 30, Cloak & Dagger, Eyewitness, Famous in Love, Grey\'s Anatomy, Guilt, Le regole del delitto perfetto, The Leftovers - Svaniti nel nulla, The Originals, Pretty Little Liars, Quantico, Reckless, Reign, Revenge, Riverdale, Scream, Sleepy Hollow, So You Think You Can Dance, Teen Wolf, Titans, The Vampire Diaries, The Walking Dead, e Wynonna Earp.'),
(5, 'Green Day', '1987-05-10', 7, 'https://i.scdn.co/image/6ead95ca5533b0b9506a5fa0a6a8dbb01cba39ec', '\r\nI Green Day sono un gruppo musicale pop punk statunitense formatosi a Berkeley nel 1986 e composto da tre membri: Billie Joe Armstrong (chitarra e voce), Mike Dirnt (basso e voce secondaria) e Tré Cool (batteria). Tré Cool sostituì l\'originario batterista Al Sobrante nel 1990, il quale abbandonò il gruppo a causa dei suoi impegni nello studio. Jason White, turnista del gruppo, è stato il quarto membro ufficiale del gruppo dal 2012 al 2016.\r\n'),
(6, 'Sfera Ebbasta', '2011-09-11', 1, 'https://i.scdn.co/image/12249ffc62893e8b0fcaca582e48ed8091c5a20a', 'Sfera Ebbasta, pseudonimo di Gionata Boschetti[3] (Sesto San Giovanni, 7 dicembre 1992), è un rapper italiano.È salito alla ribalta grazie alla pubblicazione dell\'album XDVR, inciso con la collaborazione del produttore discografico Charlie Charles, ottenendo un buon successo in Italia. Tale successo si è replicato con le uscite di Sfera Ebbasta (2016) e Rockstar (2018), il secondo dei quali ha permesso all\'artista di divenire il primo italiano ad entrare nella top 100 mondiale della piattaforma di streaming Spotify.'),
(8, 'Marracash', '1999-10-21', 1, 'https://i.scdn.co/image/cacb06125c63e22df51d01471e09609462d0ed17', 'Marracash, pseudonimo di Fabio Bartolo Rizzo (Nicosia, 22 maggio 1979), è un rapper e produttore discografico italiano.Ha esordito nel 2005 con il mixtape autoprodotto Roccia Music I, il quale ha visto la partecipazione del collettivo Dogo Gang e di altri artisti appartenenti alla scena hip hop italiana.Il mixtape ha ottenuto un riscontro significativo nel panorama hip hop underground e lo ha portato alla firma di un contratto discografico con la Universal Music Group, con la quale nel 2008 ha pubblicato il primo album solista, l\'omonimo Marracash.Nel 2013 ha fondato insieme al produttore Shablo l\'etichetta discografica indipendente Roccia Music, la quale vede coinvolte figure affermate ed emergenti dell\'hip hop italiano, tra rapper, produttori e DJ.');

-- --------------------------------------------------------

--
-- Struttura della tabella `autore`
--

CREATE TABLE `autore` (
  `codice` int(11) NOT NULL,
  `nome` varchar(20) DEFAULT NULL,
  `cognome` varchar(20) DEFAULT NULL,
  `immagine` varchar(500) DEFAULT NULL,
  `descrizione` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `autore`
--

INSERT INTO `autore` (`codice`, `nome`, `cognome`, `immagine`, `descrizione`) VALUES
(1, 'Emanuele', 'Andaloro', 'foto_autori/ema.png', 'Emanuele Andaloro nasce a Milazzo il 24/10/1999 ha sin dall’ età adolescenziale uno spiccato talento per inventare fantasiose che poi mette nei suoi testi , i suoi interessi più recenti spaziano dalla musica leggera italiana, al pop, fino a i generi come il metal e il rock. Tra i suoi cantanti preferiti troviamo Piero Pelù ,  i Metallica e i Dire Straits. Tra i premi più prestigiosi che ha vinto troviamo\r\n-Authors of our time 2016-2017\r\n'),
(2, 'Mirko', 'Trecarichi', 'foto_autori/mirko.png', 'Mirko Trecarichi nasce il 14/05/1999  a Cesarò la sua passione per la musica rock e soul lo porta a intraprendere la carriera di autore , abbandona gli studi all’età di 17 per  dedicarsi alla scrittura di testi di questo genere. Per la DBrecords ha scritto diversi brani tra cui  PROBLEMI!!.\r\nHa vinto  il premio:\r\n-Author of the year 2018-2019\r\n'),
(3, 'Carmelo', 'Calabrese', 'foto_autori/melo.png', 'Carmelo Calabrese nasce a Agira il 30/10/1999 è uno degli autori più noti della DBrecords  e anche uno di coloro che  lavora ai nostri testi da più tempo, tra i suoi maggiori successi abbiamo Dangerous thinking e what is better?.\r\n-Authors of our time 2017-2018\r\n-Writer special edition Awards \r\n'),
(4, 'Fabio', 'Castiglione', 'foto_autori/fabio.png', 'Fabio castiglione nasce il 17/08/1999  a Raddusa fin da bambino ha avuto una grande passione per la musica neomelodica napoletana , abbandona gli studi all’età di 16 per  dedicarsi alla scrittura di testi di questo genere. Per la DBrecords ha prodotto diversi brani tra cui  friends uno dei suoi brani più famosi.\r\nHa vinto diversi premi tra cui:\r\n-Writer special edition Awards\r\n-Becco di donatello 2020-2021\r\n'),
(5, 'Elena', 'Cicero', 'foto_autori/ele.png', 'Elena Cicero nasce il 05/10/2005  a Milazzo la sua passione per la musica pop e soul la porta a intraprendere la carriera di autrice , l’autrice ancora molto giovane sta continuando gli studi e nel frattempo ha intrapreso una bellissima collaborazione con la DBrecords. \r\nNon ha vinto ancora nessun premio per via della sua giovane età\r\n'),
(6, 'Giovanni', 'Caschetto', 'foto_autori/gio.png', 'Giovanni Caschetto nasce il 19/01/1990  a Modica fin da bambino ha avuto una grande passione per la musica reggae  e latino americana . Dopo alcuni problemi familiari decide di trasferirsi a Cuba lì ha iniziato a scrivere diversi testi , nel 2018 si trasferisce in Italia nuovamente ed inizia a collaborare con la nostra etichetta. Tra i suoi brani troviamo perché? e perché si?  In cui esprime i suoi sentimenti contrastanti verso la vita.');

-- --------------------------------------------------------

--
-- Struttura della tabella `brano`
--

CREATE TABLE `brano` (
  `posizione` int(11) NOT NULL,
  `album` int(11) NOT NULL,
  `Nome` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `brano`
--

INSERT INTO `brano` (`posizione`, `album`, `Nome`) VALUES
(1, 1, 'Voglio passare DB'),
(1, 2, 'Non è giusto'),
(1, 3, 'Dangerous thinking'),
(1, 4, 'Vita ingiusta!'),
(1, 5, 'What is better?'),
(1, 6, 'perchè si!'),
(2, 1, 'PROBLEMI!!'),
(2, 3, 'Friends!'),
(2, 5, 'When the rainbow comes out!'),
(2, 6, 'perche???'),
(3, 5, 'if I were fire');

--
-- Trigger `brano`
--
DELIMITER $$
CREATE TRIGGER `numero_brani3` BEFORE INSERT ON `brano` FOR EACH ROW begin
DECLARE errorMessage VARCHAR(255);
set errorMessage='non puoi inserire più di venti brani,ATTENZIONE!!!';
if((select count(*)
    from hw1_1.brano inner join hw1_1.album a on brano.album = a.codice
	where new.album=a.codice
    )=20)

then
signal sqlstate  '45000'
SET MESSAGE_TEXT = errorMessage;
else update hw1_1.album set  numero_brani=numero_brani+1
      where codice=new.album;
end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `incisione`
--

CREATE TABLE `incisione` (
  `cod` int(11) NOT NULL,
  `id_artista` int(11) DEFAULT NULL,
  `posizione` int(11) DEFAULT NULL,
  `cod_album` int(11) DEFAULT NULL,
  `cod_sala` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `incisione`
--

INSERT INTO `incisione` (`cod`, `id_artista`, `posizione`, `cod_album`, `cod_sala`) VALUES
(1, 1, 1, 1, 1),
(2, 1, 1, 2, 2),
(3, 2, 2, 2, 3),
(4, 3, 1, 3, 4),
(5, 4, 2, 3, 5),
(6, 1, 2, 5, 5),
(7, 1, 1, 5, 5),
(8, 1, 3, 5, 4),
(9, 2, 1, 4, 3),
(10, 5, 3, 5, 4),
(11, 6, 2, 5, 2),
(12, 1, 2, 1, 5),
(13, 2, 1, 6, 1),
(14, 2, 2, 6, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `newsletter`
--

CREATE TABLE `newsletter` (
  `descrizione` varchar(500) NOT NULL,
  `checkbox` tinyint(1) DEFAULT NULL,
  `id_newsletter` int(11) NOT NULL,
  `email` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `newsletter`
--

INSERT INTO `newsletter` (`descrizione`, `checkbox`, `id_newsletter`, `email`) VALUES
('mi piace pippo?', 1, 1, 'ele@gmail.com');

-- --------------------------------------------------------

--
-- Struttura della tabella `preferiti`
--

CREATE TABLE `preferiti` (
  `id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_pref` int(11) NOT NULL,
  `titolo` varchar(30) DEFAULT NULL,
  `immagine` varchar(200) DEFAULT NULL,
  `tipo` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `preferiti`
--

INSERT INTO `preferiti` (`id`, `time`, `id_pref`, `titolo`, `immagine`, `tipo`) VALUES
(13, '2021-05-18 16:30:38', 13, 'Elena Coats', 'https://i.scdn.co/image/be9c273afc15d02da621dbb9a7b4b6f6c7c9a23b', 'artist'),
(13, '2021-05-18 16:31:23', 15, 'Pippo Franco', 'https://i.scdn.co/image/ab67616d00001e026da2bd1aeb86b4934fb80d35', 'artist'),
(13, '2021-05-18 16:36:53', 17, 'Sad Song (feat. Elena Coats)', 'https://i.scdn.co/image/ab67616d00001e02a358003c337056b9965a9c0f', 'track'),
(11, '2021-05-23 18:36:41', 194, 'Jah Fabio', 'https://i.scdn.co/image/ab6761610000517435c63d34137831e7737c494e', 'artist'),
(11, '2021-05-23 18:37:01', 196, 'Fabio Vee', 'https://i.scdn.co/image/5d41d883d07c26d38c9514b9a0a59ca803865e35', 'artist'),
(11, '2021-05-24 13:43:30', 208, 'Fabio Di Bari', 'https://i.scdn.co/image/ab67616d00001e02d9700fc123a833bf30547fad', 'artist'),
(11, '2021-05-24 14:30:11', 209, 'Jimi Hendrix', 'https://i.scdn.co/image/ab67616d00001e02522088789d49e216d9818292', 'album'),
(11, '2021-05-24 16:51:16', 211, 'Fabio', 'https://i.scdn.co/image/ab67616d00001e020fbea2e7af77a42cd3dc77c5', 'track'),
(11, '2021-05-24 17:31:45', 212, 'Trippie Redd', 'https://i.scdn.co/image/ab67616d00001e02d9b293fd7af470ec2c58e75f', 'album'),
(17, '2021-05-24 18:53:25', 213, 'Brent Faiyaz', 'https://i.scdn.co/image/9dae67e4f0557d04cbaaabd8cad1df7f75e2fd36', 'artist'),
(17, '2021-05-24 18:53:34', 214, 'Billie Eilish', 'https://i.scdn.co/image/ab67616d00001e0250a3147b4edd7701a876c6ce', 'album');

--
-- Trigger `preferiti`
--
DELIMITER $$
CREATE TRIGGER `preferiti_2` BEFORE INSERT ON `preferiti` FOR EACH ROW begin
    DECLARE errorMessage VARCHAR(255);
    set errorMessage='preferito duplicato!!!';
    if(select count(*)
       from hw1_1.preferiti
       where NEW.id=preferiti.id and NEW.titolo=preferiti.titolo and new.immagine=preferiti.immagine)>0
    then
        signal sqlstate  '45000'
            SET MESSAGE_TEXT = errorMessage;
    end if ;

    end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `sala_di_registrazione`
--

CREATE TABLE `sala_di_registrazione` (
  `codice` int(11) NOT NULL,
  `numero_max` int(11) DEFAULT NULL,
  `indirizzo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `sala_di_registrazione`
--

INSERT INTO `sala_di_registrazione` (`codice`, `numero_max`, `indirizzo`) VALUES
(1, 5, 'Via verdi 19'),
(2, 3, 'Via Giacomo Puccini 92'),
(3, 6, 'Via Della Resistenza 29'),
(4, 9, 'Via Vittorio Emanuele 30'),
(5, 8, 'Via Soldato Cavallaro 31');

-- --------------------------------------------------------

--
-- Struttura della tabella `scrittura`
--

CREATE TABLE `scrittura` (
  `autore` int(11) NOT NULL,
  `posizione` int(11) NOT NULL,
  `album` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `scrittura`
--

INSERT INTO `scrittura` (`autore`, `posizione`, `album`) VALUES
(1, 1, 2),
(2, 1, 4),
(2, 2, 1),
(2, 2, 5),
(3, 1, 1),
(3, 1, 5),
(4, 2, 3),
(5, 1, 3),
(5, 3, 5),
(6, 1, 6),
(6, 2, 6);

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE `utenti` (
  `password` varchar(500) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `nome` varchar(20) DEFAULT NULL,
  `cognome` varchar(20) DEFAULT NULL,
  `id_user` int(11) NOT NULL,
  `username` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `utenti`
--

INSERT INTO `utenti` (`password`, `email`, `nome`, `cognome`, `id_user`, `username`) VALUES
('$2y$10$Rroaf.onYw2xHQe9wC2QlOnhNB1z18Qv7msKZC4DxbscDJPDkg3Bu', 'pippo@melopippo.it', 'pippo', 'pippo', 11, 'pippo'),
('$2y$10$aJNC6v6ADgNqeTnkzAeh0.i6Mj89vWQNJ3Ey5okycQz5KB5bks8KS', 'fabio@castiglione.com', 'fabui', 'castiglione', 12, 'fa'),
('$2y$10$6sZPGydEM7jT2q2y19Xg8uN.S/Jr6Ho.mOdPsmPQ7FvE8c52NKyv.', 'manu_anda@libero.com', '1234', '1234', 13, 'ema'),
('$2y$10$jjx1AC.8b64XbZaFEZCHAeqr0gZ1s0P4/wOa8HqVzUDbBOhYoUFq6', 'io.costa@gmail.com', 'io', 'costa', 14, 'elon'),
('$2y$10$9LyzcI7vQiyaKBTDczOAd.b1zQegt55x5PhpBTs0IqcmO.Q92viJi', 'deidara@gmail.com', 'fvfv', 'fvvvfvf', 15, 'fvvfvf'),
('$2y$10$xQWBMWDbgx/ABxWCvL4PMO8aD.Ruc159K94W.oSXKFu/lOf570aLW', 'gloria.ofria@gmail.com', 'gloria', 'ofria', 16, 'gloria'),
('$2y$10$0San/TVGopiF960zFjl0zeKqvJ.fhqxzV7PMeYfX6NlRfHJehU2kG', 'xxx@xxx.it', 'xxx', 'xxx', 17, 'xxx');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `album`
--
ALTER TABLE `album`
  ADD PRIMARY KEY (`codice`);

--
-- Indici per le tabelle `artista`
--
ALTER TABLE `artista`
  ADD PRIMARY KEY (`ID`);

--
-- Indici per le tabelle `autore`
--
ALTER TABLE `autore`
  ADD PRIMARY KEY (`codice`);

--
-- Indici per le tabelle `brano`
--
ALTER TABLE `brano`
  ADD PRIMARY KEY (`posizione`,`album`),
  ADD KEY `new_idxalbum` (`album`);

--
-- Indici per le tabelle `incisione`
--
ALTER TABLE `incisione`
  ADD PRIMARY KEY (`cod`),
  ADD KEY `incisione_ibfk_1` (`id_artista`),
  ADD KEY `incisione_ibfk_2` (`cod_album`),
  ADD KEY `incisione_ibfk_3` (`posizione`),
  ADD KEY `incisione_ibfk_4` (`cod_sala`);

--
-- Indici per le tabelle `newsletter`
--
ALTER TABLE `newsletter`
  ADD PRIMARY KEY (`id_newsletter`);

--
-- Indici per le tabelle `preferiti`
--
ALTER TABLE `preferiti`
  ADD PRIMARY KEY (`id_pref`),
  ADD KEY `preferiti_ibfk_1` (`id`);

--
-- Indici per le tabelle `sala_di_registrazione`
--
ALTER TABLE `sala_di_registrazione`
  ADD PRIMARY KEY (`codice`);

--
-- Indici per le tabelle `scrittura`
--
ALTER TABLE `scrittura`
  ADD PRIMARY KEY (`autore`,`posizione`,`album`),
  ADD KEY `new_album` (`album`),
  ADD KEY `new_autore` (`autore`),
  ADD KEY `new_posizione` (`posizione`);

--
-- Indici per le tabelle `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `newsletter`
--
ALTER TABLE `newsletter`
  MODIFY `id_newsletter` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT per la tabella `preferiti`
--
ALTER TABLE `preferiti`
  MODIFY `id_pref` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=215;

--
-- AUTO_INCREMENT per la tabella `utenti`
--
ALTER TABLE `utenti`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `brano`
--
ALTER TABLE `brano`
  ADD CONSTRAINT `brano_ibfk_1` FOREIGN KEY (`album`) REFERENCES `album` (`codice`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `incisione`
--
ALTER TABLE `incisione`
  ADD CONSTRAINT `incisione_ibfk_1` FOREIGN KEY (`id_artista`) REFERENCES `artista` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `incisione_ibfk_2` FOREIGN KEY (`cod_album`) REFERENCES `album` (`codice`) ON UPDATE CASCADE,
  ADD CONSTRAINT `incisione_ibfk_3` FOREIGN KEY (`posizione`) REFERENCES `brano` (`posizione`) ON UPDATE CASCADE,
  ADD CONSTRAINT `incisione_ibfk_4` FOREIGN KEY (`cod_sala`) REFERENCES `sala_di_registrazione` (`codice`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `preferiti`
--
ALTER TABLE `preferiti`
  ADD CONSTRAINT `preferiti_ibfk_1` FOREIGN KEY (`id`) REFERENCES `utenti` (`id_user`);

--
-- Limiti per la tabella `scrittura`
--
ALTER TABLE `scrittura`
  ADD CONSTRAINT `scrittura_ibfk_1` FOREIGN KEY (`autore`) REFERENCES `autore` (`codice`) ON UPDATE CASCADE,
  ADD CONSTRAINT `scrittura_ibfk_2` FOREIGN KEY (`posizione`) REFERENCES `brano` (`posizione`) ON UPDATE CASCADE,
  ADD CONSTRAINT `scrittura_ibfk_3` FOREIGN KEY (`album`) REFERENCES `album` (`codice`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
