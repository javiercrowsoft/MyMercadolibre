<?php

require "./error.php";
require './config.php';
require './database.php';
require './user.php';
require './util.php';
require './profile.php';

define('ITEMS_ROW_LIMIT', 200);
define('MAX_SENT', 50);

$debug = isset($_GET['debug']) ? $_GET['debug'] === 'yes' : false;

if ($debug) {
?>

<!doctype html>
<html>
	<head>
		<meta charset="UTF-8"/>
		<title>CrowSoft CSCVXI Profile Show (debug)</title>
	</head>
	<body>
		<h2>CrowSoft CSCVXI</h2>
		<h1>Profile Show (debug)</h1>

<?php
}
else {

	header('Content-type: application/json');	

}

	$in_debug = $debug;

    // get user
    $nick = $_GET['nick'];

    if ($nick === "demo") {
    	$response = '{"data":[{"seller_id":"86284620","seller_name":"*TECHNOENE...(3051)","item_id":"464039802","item_name":"Notebook Sony Vaio...$4999.98"},{"seller_id":"38114158","seller_name":"OX ARTIS...(717)","item_id":"456867545","item_name":"Libreta Canson Art Book Universal E...$90.00"},{"seller_id":"25101314","seller_name":"LARIT...(29)","item_id":"458127787","item_name":"Espectacular Jogging Importado Nena...$160.00"},{"seller_id":"70189924","seller_name":"VANESADEALECSANDRI...(122)","item_id":"447626337","item_name":"Remeras Oshkosh \/carters Talles 2t ...$50.00"},{"seller_id":"85349181","seller_name":"PAAULI...(31)","item_id":"449855557","item_name":"Campera Carter S De Nena...$50.00"},{"seller_id":"57996292","seller_name":"VIVIANAG_DR...(76)","item_id":"449265739","item_name":"Pijama Cars.- $150...$150.00"},{"seller_id":"53815111","seller_name":"PLAZAITALI...(1736)","item_id":"447921419","item_name":"Manual De Psicomagia. Alejandro Jod...$59.00"},{"seller_id":"85501460","seller_name":"URBAN-S...(19459)","item_id":"439401485","item_name":"Cartucho Hp 21 60 92 74 Tinta Negra...$129.00"},{"seller_id":"92431493","seller_name":"AVEFENIX999100...(172)","item_id":"442289847","item_name":"Jeans Cheeky  T4...$75.00"},{"seller_id":"17260164","seller_name":"FERIASLO...(13)","item_id":"443811191","item_name":"Pantalon De Jean Talle 2 Cheeky Gir...$40.00"},{"seller_id":"17260164","seller_name":"FERIASLO...(13)","item_id":"442593341","item_name":"Camisa De Jean John Cook Talle 2 Ne...$35.00"},{"seller_id":"66788308","seller_name":"MARIAFERNANDEZ61...(76)","item_id":"443470626","item_name":"Campera De Varon T5 -6  Marca Zara...$99.99"},{"seller_id":"16689228","seller_name":"ZAPAGI...(48)","item_id":"441289814","item_name":"Campera De Gabardina Importada C\/ca...$80.00"},{"seller_id":"12715225","seller_name":"RECORCHOLIS JUGUETE...(4060)","item_id":"442944753","item_name":"Monopatin Quickly Vegui Colores Uni...$159.00"},{"seller_id":"68019424","seller_name":"NIVELDIGI...(23223)","item_id":"440151994","item_name":"Auto Transformers Bumblebee Articul...$199.99"},{"seller_id":"96338200","seller_name":"MR-SHO...(26428)","item_id":"0","item_name":"#243; Mp4 I-modo F60 4gb  Tipo Nano 6&#186; Ge...$159.99"},{"seller_id":"102955744","seller_name":"IM SHE...(1251)","item_id":"0","item_name":"#243; Maquina Cortapelo Profesional Centu...$99.54"},{"seller_id":"16516290","seller_name":"IP...(175)","item_id":"0","item_name":"#243; Zapatilla (zapatos) Con Clavos Para...$420.00"},{"seller_id":"37936522","seller_name":"-MRSALE...(13633)","item_id":"0","item_name":"#243; Ventilador De Pie Atma Vp8042e 50 C...$479.00"},{"seller_id":"30138062","seller_name":"MUNID...(20324)","item_id":"0","item_name":"#243; Zapatillas Ni&#241;o Looney Tunes Con Lu...$149.99"},{"seller_id":"65354020","seller_name":"OUTLETONLIN...(940)","item_id":"0","item_name":"#243; Baby Tweety Outlet Con Luces...$50.00"},{"seller_id":"115966239","seller_name":"PUMARVIVIAN...(22)","item_id":"0","item_name":"#243; Paquete Ropa Ni&#241;as Importada Usa......$290.00"},{"seller_id":"43099612","seller_name":"MGT2...(42)","item_id":"0","item_name":"#243; Excelente Campera Tipo Rompeviento ...$60.00"},{"seller_id":"75579294","seller_name":"VOYAGERCOMPUTACIO...(18930)","item_id":"0","item_name":"#243; Transmisor Fm Pen Mp3 Mp4 Mp5 Memor...$39.99"},{"seller_id":"36090015","seller_name":"LETIBO...(201)","item_id":"0","item_name":"#243; Impecable Jean Gap Ni&#241;o Talle 4 Ori...$75.00"},{"seller_id":"91354081","seller_name":"NATALIA2...(389)","item_id":"0","item_name":"#243; Lote Remera Gymboree Importada+jean...$70.00"},{"seller_id":"37446133","seller_name":"NEW_ANVER...(319)","item_id":"0","item_name":"#243; Cartera Cl&#225;sica Matelasse Importada...$189.00"},{"seller_id":"82353244","seller_name":"ACCESORIOSYPARTE...(2257)","item_id":"0","item_name":"#243; Sillas De Oficina Ergonomica Cromad...$982.04"},{"seller_id":"13254257","seller_name":"MIMUNDOBA...(206)","item_id":"0","item_name":"#243; Calzas Leggins Para Bebes! Pantalon...$49.00"},{"seller_id":"9558292","seller_name":"NUEVAS CRIATURA...(4502)","item_id":"0","item_name":"#243; L&#225;tex Prevulcanizado Goma Latex L&#237;q...$30.00"},{"seller_id":"95006123","seller_name":"ALEYA...(133)","item_id":"0","item_name":"#243; Campera Importada Oskkosh T4...$185.00"},{"seller_id":"92371600","seller_name":"PAULO-...(79)","item_id":"0","item_name":"#243; Plancha Digital Black & Decker D169...$250.00"},{"seller_id":"102002909","seller_name":"MUNDO-AZU...(532)","item_id":"0","item_name":"#243; PANTALON JOGGING FRIZA COLEGIAL DEP...$27.00"},{"seller_id":"67773560","seller_name":"VANESSASTRACHCAP...(24)","item_id":"0","item_name":"#243; CAMISETA DE AMAMANTAR BRETELES DESM...$62.00"},{"seller_id":"21405796","seller_name":"MYC...(4758)","item_id":"0","item_name":"#243; Auriculares Sennheiser CX-300 Preci...$279.99"},{"seller_id":"56955809","seller_name":"JNLSUPPLEM...(1018)","item_id":"0","item_name":"#243; Jack 3d X 250 Grs....$350.00"},{"seller_id":"13430630","seller_name":"MAMAME...(608)","item_id":"0","item_name":"#243; Cintas con Nombre para Ropa - 40 No...$35.00"},{"seller_id":"25047020","seller_name":"TITI20102...(161)","item_id":"0","item_name":"#243; Calzoncillos Disney...$80.00"},{"seller_id":"67472889","seller_name":"TINO...(963)","item_id":"0","item_name":"#243; Butaca Para Auto Kiddy Le Mans Con ...$1229.00"},{"seller_id":"41409807","seller_name":"GRUPOEMPOR...(5661)","item_id":"0","item_name":"#243; Estufa Calefactor Halogeno 400\/800\/...$159.99"},{"seller_id":"48430956","seller_name":"LATIN TECHNOLO...(12280)","item_id":"0","item_name":"#243; Disco Rigido Externo Usb Samsung 40...$323.99"},{"seller_id":"50617100","seller_name":"CASTANOMARIAN...(429)","item_id":"0","item_name":"#243; Cars 2 - Disney Grua Mate a Radio C...$70.00"},{"seller_id":"63021883","seller_name":"RCINACTI...(1219)","item_id":"0","item_name":"#243; MICRO SERVO DIGITAL 9G  Para Futaba...$25.00"},{"seller_id":"77321778","seller_name":"DITEN-T...(198)","item_id":"0","item_name":"#243; Arduino - arduino UNO ATMega328 Dis...$190.00"},{"seller_id":"33997073","seller_name":"XPV...(170)","item_id":"0","item_name":"#243; LOTES ROPA PRENATAL EMBARAZ FUTURA ...$200.00"},{"seller_id":"22738576","seller_name":"MAQUINERIAJUAN...(8588)","item_id":"0","item_name":"#243; MAQUINA DE COSER BROTHER DIGITAL 10...$1575.00"},{"seller_id":"82077110","seller_name":"ELECTROVEND...(25979)","item_id":"0","item_name":"#243; Camara Digital Nikon L20 10mp Lcd 3...$489.90"}],"status":1}';
    	echo $response;
    	exit();
    }
    
    $meli_user_id = cs_profile_get_meli_user_id($nick);
    $response = new stdClass;
    
    try {
    	$response->data = cs_profile_get_seller_list($meli_user_id);;
    	$response->status = 1;
    } catch(Exception $e) {
    	$response->error_code = CS_UNEXPECTED_ERROR;
    	$response->status = 0;
    }
	
    $response = json_encode($response);

if ($debug) {    
    echo indent($response);
}
else {
	echo $response;
}

if ($debug) {
?>

	</body>
</html>

<?php
}
?>