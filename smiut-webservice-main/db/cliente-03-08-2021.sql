-- --------------------------------------------------------
-- Anfitrião:                    cozinhaspl.pt
-- Versão do servidor:           10.3.28-MariaDB-cll-lve - MariaDB Server
-- Server OS:                    Linux
-- HeidiSQL Versão:              10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for cozinhaspl_site
CREATE DATABASE IF NOT EXISTS `cozinhaspl_site` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `cozinhaspl_site`;

-- Dumping structure for table cozinhaspl_site.acesso
CREATE TABLE IF NOT EXISTS `acesso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `super_administrador` tinyint(4) DEFAULT 0,
  `username` varchar(250) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL,
  `password_salt` varchar(10) DEFAULT NULL,
  `cod_recupera` varchar(255) DEFAULT NULL,
  `roles` tinyint(4) DEFAULT 1,
  `primeiro_nome` varchar(255) DEFAULT NULL,
  `ultimo_nome` varchar(255) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `funcao` varchar(40) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `imagem` varchar(250) DEFAULT NULL,
  `last_activity` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `notif_from` datetime DEFAULT NULL,
  `lingua` varchar(20) DEFAULT 'pt',
  `activo` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `indice` (`username`(191),`activo`,`email`(191),`super_administrador`,`last_activity`,`last_login`,`notif_from`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cozinhaspl_site.acesso: ~0 rows (approximately)
/*!40000 ALTER TABLE `acesso` DISABLE KEYS */;
INSERT INTO `acesso` (`id`, `super_administrador`, `username`, `password`, `password_salt`, `cod_recupera`, `roles`, `primeiro_nome`, `ultimo_nome`, `email`, `telefone`, `funcao`, `observacoes`, `imagem`, `last_activity`, `last_login`, `notif_from`, `lingua`, `activo`) VALUES
	(1, 1, 'netg', 'a31328e1b6df31425f6e97467e5993e5e7d3cfcce7322ec7cf2d1267a6d04954', '7f5', NULL, 1, 'Netgocio', 'Suporte', 'suporte@netgocio.pt', '1332', '343', '563', 'users/1674325759.webp', '2015-10-12 15:19:06', '2015-10-12 15:18:53', '2015-10-12 15:18:53', 'pt', 1),
	(2, 0, 'cozinhaspl', 'ee28b5b8e7ad3ac42080d267252c4033348fb2947eb30d0c1c5751580acf45ba', '37b', NULL, 0, 'cozinhas', 'pl', 'marketing@cozinhaspl.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'pt', 1);
/*!40000 ALTER TABLE `acesso` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.config
CREATE TABLE IF NOT EXISTS `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `ano` int(11) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `ecommerce` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.config: ~0 rows (approximately)
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` (`id`, `nome`, `ano`, `descricao`, `ecommerce`) VALUES
	(1, 'Netgocio Consola', 2022, 'descricao do site', NULL);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.config_api
CREATE TABLE IF NOT EXISTS `config_api` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `codigo` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `visivel` int(11) DEFAULT 0,
  `descricao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cozinhaspl_site.config_api: ~0 rows (approximately)
/*!40000 ALTER TABLE `config_api` DISABLE KEYS */;
INSERT INTO `config_api` (`id`, `nome`, `codigo`, `visivel`, `descricao`) VALUES
	(1, 'Google Analytics', 'UA-XXXXXXXX', 1, ' Universal Analytics ("UA-XXXXXXXX"),<br>Google Analytics 4');
/*!40000 ALTER TABLE `config_api` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.config_empresa
CREATE TABLE IF NOT EXISTS `config_empresa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) CHARACTER SET latin1 NOT NULL,
  `ano` int(11) DEFAULT NULL,
  `descricao` text CHARACTER SET latin1 DEFAULT NULL,
  `morada` text CHARACTER SET latin1 DEFAULT NULL,
  `morada2` text CHARACTER SET latin1 DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `link_google_maps` text CHARACTER SET latin1 DEFAULT NULL,
  `livro_reclamacao` tinyint(1) DEFAULT 0,
  `manutencao` int(11) DEFAULT 0,
  `ips` text CHARACTER SET latin1 DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cozinhaspl_site.config_empresa: ~0 rows (approximately)
/*!40000 ALTER TABLE `config_empresa` DISABLE KEYS */;
INSERT INTO `config_empresa` (`id`, `nome`, `ano`, `descricao`, `morada`, `morada2`, `email`, `link_google_maps`, `livro_reclamacao`, `manutencao`, `ips`, `url`) VALUES
	(1, 'Cozinhas PL', 2022, 'descricao do site', '<p>Rua da Cepeda, 89<br>Antime, 4820-005 Fafe<br>Tel. +351 253 495 326</p>', '<p>Rua da Noruega, 26<br>Antime, 4820-196 Fafe<br>Tel. +351 253 491 336</p>', 'geral@cozinhaspl.com', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2990.565436171927!2d-8.178255884572314!3d41.44865007925858!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd24e85fbe67e66d%3A0x899d6f1ee8c8ac36!2sR.%20da%20Noruega%2026%2C%204820-196%20Fafe%2C%20Portugal!5e0!3m2!1spt-BR!2sbr!4v1619213750928!5m2!1spt-BR!2sbr" width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy"></iframe>', 1, 1, '["94.61.179.113","89.154.90.120","148.63.188.150","187.110.146.106","188.37.127.84","89.154.177.134"]', NULL);
/*!40000 ALTER TABLE `config_empresa` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.config_integracoes_tagmanager
CREATE TABLE IF NOT EXISTS `config_integracoes_tagmanager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `tag` text DEFAULT NULL,
  `tipo` varchar(10) DEFAULT 'head',
  `ordem` int(11) DEFAULT 99,
  `visivel` int(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.config_integracoes_tagmanager: 3 rows
/*!40000 ALTER TABLE `config_integracoes_tagmanager` DISABLE KEYS */;
INSERT INTO `config_integracoes_tagmanager` (`id`, `nome`, `tag`, `tipo`, `ordem`, `visivel`) VALUES
	(1, 'Google Analytics  Teste', '<!-- Global site tag (gtag.js) - Google Analytics -->\r\n<script async src="https://www.googletagmanager.com/gtag/js?id=G-6Y1H5QC9C2"></script>\r\n<script>\r\n  window.dataLayer = window.dataLayer || [];\r\n  function gtag(){dataLayer.push(arguments);}\r\n  gtag(\'js\', new Date());\r\n\r\n  gtag(\'config\', \'G-6Y1H5QC9C2\');\r\n</script>\r\n', 'head', 8, 0),
	(2, 'Google Analytics', '<!-- Global site tag (gtag.js) - Google Analytics -->\n<script async src="https://www.googletagmanager.com/gtag/js?id=UA-202239223-1"></script>\n<script>\n  window.dataLayer = window.dataLayer || [];\n  function gtag(){dataLayer.push(arguments);}\n  gtag(\'js\', new Date());\n\n  gtag(\'config\', \'UA-202239223-1\');\n</script>', 'head', 99, 1),
	(3, 'Pixel', '<!-- Facebook Pixel Code -->\n<script>\n  !function(f,b,e,v,n,t,s)\n  {if(f.fbq)return;n=f.fbq=function(){n.callMethod?\n  n.callMethod.apply(n,arguments):n.queue.push(arguments)};\n  if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version=\'2.0\';\n  n.queue=[];t=b.createElement(e);t.async=!0;\n  t.src=v;s=b.getElementsByTagName(e)[0];\n  s.parentNode.insertBefore(t,s)}(window, document,\'script\',\n  \'https://connect.facebook.net/en_US/fbevents.js\');\n  fbq(\'init\', \'420893448789897\');\n  fbq(\'track\', \'PageView\');\n</script>\n<noscript><img height="1" width="1" style="display:none"\n  src="https://www.facebook.com/tr?id=420893448789897&ev=PageView&noscript=1"\n/></noscript>\n<!-- End Facebook Pixel Code -->', 'head', 99, 1);
/*!40000 ALTER TABLE `config_integracoes_tagmanager` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.config_redes_sociais
CREATE TABLE IF NOT EXISTS `config_redes_sociais` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `link` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `visivel` int(11) DEFAULT 0,
  `ref` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table cozinhaspl_site.config_redes_sociais: ~5 rows (approximately)
/*!40000 ALTER TABLE `config_redes_sociais` DISABLE KEYS */;
INSERT INTO `config_redes_sociais` (`id`, `nome`, `link`, `visivel`, `ref`) VALUES
	(1, 'Facebook', 'https://www.facebook.com/cozinhaspl', 1, 'facebook'),
	(2, 'Instagram', 'https://www.instagram.com/cozinhas_pl/', 1, 'instagram'),
	(3, 'Twitter', '', 1, 'twitter'),
	(4, 'Youtube', '', 1, 'youtube'),
	(5, 'Linkedin', 'https://www.linkedin.com/company/cozinhas-pl/', 1, 'linkedin');
/*!40000 ALTER TABLE `config_redes_sociais` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_banners_pt
CREATE TABLE IF NOT EXISTS `l_banners_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `visivel` int(11) DEFAULT 1,
  `ordem` int(11) DEFAULT NULL,
  `ref` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_banners_pt: 1 rows
/*!40000 ALTER TABLE `l_banners_pt` DISABLE KEYS */;
INSERT INTO `l_banners_pt` (`id`, `nome`, `descricao`, `visivel`, `ordem`, `ref`) VALUES
	(1, 'Página Home', '', 1, 1, 'banner_home');
/*!40000 ALTER TABLE `l_banners_pt` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_banners_slides
CREATE TABLE IF NOT EXISTS `l_banners_slides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_banners` int(11) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `subtitulo` varchar(255) DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `tipo_upload` int(1) DEFAULT NULL,
  `link_texto` varchar(255) DEFAULT NULL,
  `link_url` varchar(255) DEFAULT NULL,
  `link_target` varchar(255) DEFAULT '_blank',
  `video` varchar(255) DEFAULT NULL,
  `visivel` int(11) DEFAULT 0,
  `add_texto` int(1) NOT NULL,
  `ordem` int(11) DEFAULT 99,
  `desktop_tem_mascara` int(1) DEFAULT NULL,
  `desktop_mascara` varchar(50) DEFAULT NULL,
  `desktop_cor_texto` varchar(50) DEFAULT NULL,
  `desktop_alinhamento_horizontal` varchar(50) DEFAULT NULL,
  `desktop_alinhamento_vertical` varchar(50) DEFAULT NULL,
  `desktop_imagem` varchar(50) DEFAULT NULL,
  `desktop_mascara_opacidade` int(11) NOT NULL DEFAULT 100,
  `desktop_cor_texto_botao` varchar(50) NOT NULL,
  `desktop_cor_botao` varchar(50) NOT NULL,
  `mobile_tem_mascara` int(1) DEFAULT NULL,
  `mobile_mascara` varchar(50) DEFAULT NULL,
  `mobile_cor_texto` varchar(50) DEFAULT NULL,
  `mobile_cor_botao` varchar(50) NOT NULL,
  `mobile_cor_texto_botao` varchar(50) NOT NULL,
  `mobile_alinhamento_horizontal` varchar(50) DEFAULT NULL,
  `mobile_alinhamento_vertical` varchar(50) DEFAULT NULL,
  `mobile_imagem` varchar(50) DEFAULT NULL,
  `mobile_mascara_opacidade` int(11) NOT NULL DEFAULT 100,
  `id_tipo_imagens` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_l_banners_slides_l_banners_pt` (`id_banners`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_banners_slides: 2 rows
/*!40000 ALTER TABLE `l_banners_slides` DISABLE KEYS */;
INSERT INTO `l_banners_slides` (`id`, `id_banners`, `nome`, `titulo`, `subtitulo`, `data_inicio`, `data_fim`, `tipo_upload`, `link_texto`, `link_url`, `link_target`, `video`, `visivel`, `add_texto`, `ordem`, `desktop_tem_mascara`, `desktop_mascara`, `desktop_cor_texto`, `desktop_alinhamento_horizontal`, `desktop_alinhamento_vertical`, `desktop_imagem`, `desktop_mascara_opacidade`, `desktop_cor_texto_botao`, `desktop_cor_botao`, `mobile_tem_mascara`, `mobile_mascara`, `mobile_cor_texto`, `mobile_cor_botao`, `mobile_cor_texto_botao`, `mobile_alinhamento_horizontal`, `mobile_alinhamento_vertical`, `mobile_imagem`, `mobile_mascara_opacidade`, `id_tipo_imagens`) VALUES
	(44, 1, NULL, 'Descubra a sua cozinha de sonho', '“Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean nisl turpis, ultricies interdum malesuada nec.', '2021-07-01', '2021-08-05', 1, 'Explorar', 'www.google.pt', '_self', NULL, 1, 0, 2, 1, '#252526', '#ffffff', 'left', 'center', 'banners/13009554192.webp', 100, '', '', 1, NULL, '#ffffff', '#ffffff', '', 'left', 'center', 'banners/13009554192.webp', 100, 0),
	(45, 1, NULL, 'Lorem ipsum dolor sit amet', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean nisl turpis, ultricies interdum malesuada nec.', '2021-07-07', '2021-07-31', 1, 'explorar', 'projetos', '_blank', NULL, 1, 0, 1, 1, '#252526', '#ffffff', 'left', 'center', 'banners/9757165716.webp', 100, '', '', NULL, NULL, NULL, '', '', NULL, NULL, 'banners/9757165716.webp', 100, 0);
/*!40000 ALTER TABLE `l_banners_slides` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_catalogos_pt
CREATE TABLE IF NOT EXISTS `l_catalogos_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `ficheiro` varchar(255) DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `visivel` int(1) DEFAULT 0,
  `ordem` int(11) NOT NULL DEFAULT 99,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_catalogos_pt: ~2 rows (approximately)
/*!40000 ALTER TABLE `l_catalogos_pt` DISABLE KEYS */;
INSERT INTO `l_catalogos_pt` (`id`, `nome`, `ficheiro`, `imagem`, `visivel`, `ordem`) VALUES
	(3, 'Catálogo 21', 'catalogos/184311343.jpg', 'catalogos/1343846908.webp', 1, 99),
	(4, 'Catalogo 2021', NULL, NULL, 1, 99);
/*!40000 ALTER TABLE `l_catalogos_pt` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_categorias_pt
CREATE TABLE IF NOT EXISTS `l_categorias_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `id_categorias_tipo` int(11) DEFAULT NULL,
  `visivel` int(11) DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `ordem` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_l_categorias_pt_l_categorias_tipos_pt` (`id_categorias_tipo`),
  CONSTRAINT `FK_l_categorias_pt_l_categorias_tipos_pt` FOREIGN KEY (`id_categorias_tipo`) REFERENCES `l_categorias_tipos_pt` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_categorias_pt: ~20 rows (approximately)
/*!40000 ALTER TABLE `l_categorias_pt` DISABLE KEYS */;
INSERT INTO `l_categorias_pt` (`id`, `nome`, `descricao`, `id_categorias_tipo`, `visivel`, `url`, `ordem`) VALUES
	(12, 'Escandinavo', NULL, 1, 1, 'Categoria_1', NULL),
	(13, 'Cozinhas Modernas', NULL, 4, 1, 'Categoria_1', NULL),
	(14, 'Categorias Notícias', NULL, 3, 1, 'Categorias_Noticias', NULL),
	(15, 'Categoria páginas', NULL, 6, 1, 'Categoria_paginas', NULL),
	(16, 'List-5', NULL, 8, 1, 'list_5', NULL),
	(17, 'Estilo Clássico', NULL, 1, 1, 'estilo_classico', NULL),
	(18, 'Estilo Contemporâneo', NULL, 1, 1, 'estilo_contemporaneo', NULL),
	(19, 'Estilo Industrial', NULL, 1, 1, 'estilo_industrial', NULL),
	(20, 'Estilo Minimalista', NULL, 1, 1, 'estilo_minimalista', NULL),
	(21, 'Estilo Moderno', NULL, 1, 1, 'estilo_moderno', NULL),
	(22, 'Estratificado', NULL, 2, 1, 'estratificado', NULL),
	(23, 'Fénix', NULL, 2, 1, 'fenix', NULL),
	(24, 'Lacado', NULL, 2, 1, 'lacado', NULL),
	(25, 'Madeira Carbonizada ', NULL, 2, 1, 'madeira_carbonizada', NULL),
	(26, 'Madeiras', NULL, 2, 1, 'madeiras', NULL),
	(27, 'Melaminas', NULL, 2, 1, 'melaminas', NULL),
	(28, 'Vidro', NULL, 2, 1, 'vidro', NULL),
	(29, 'Categorias Catálogos', NULL, 9, 1, 'categorias_catalogos', NULL),
	(42, 'qweqwe', NULL, 6, 1, 'qweqwe', NULL),
	(43, 'Cozinhas Clássicas', NULL, 4, 1, 'cozinhas_classicas', NULL);
/*!40000 ALTER TABLE `l_categorias_pt` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_categorias_tipos_pt
CREATE TABLE IF NOT EXISTS `l_categorias_tipos_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `descricao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_categorias_tipos_pt: ~9 rows (approximately)
/*!40000 ALTER TABLE `l_categorias_tipos_pt` DISABLE KEYS */;
INSERT INTO `l_categorias_tipos_pt` (`id`, `nome`, `descricao`) VALUES
	(1, 'Cozinhas', NULL),
	(2, 'Materiais', NULL),
	(3, 'Noticias', NULL),
	(4, 'Projetos', NULL),
	(5, 'Personalizacoes', NULL),
	(6, 'Paginas', NULL),
	(7, 'Home', NULL),
	(8, 'Newsletter', NULL),
	(9, 'Catalogos', NULL);
/*!40000 ALTER TABLE `l_categorias_tipos_pt` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_config_categoria_imagens
CREATE TABLE IF NOT EXISTS `l_config_categoria_imagens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(50) DEFAULT NULL,
  `descricao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_config_categoria_imagens: ~6 rows (approximately)
/*!40000 ALTER TABLE `l_config_categoria_imagens` DISABLE KEYS */;
INSERT INTO `l_config_categoria_imagens` (`id`, `categoria`, `descricao`) VALUES
	(1, 'produto', NULL),
	(2, 'banner', NULL),
	(3, 'topo', NULL),
	(4, 'noticias', NULL),
	(5, 'materiais', NULL),
	(6, 'personalizacoes', NULL);
/*!40000 ALTER TABLE `l_config_categoria_imagens` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_config_imagens
CREATE TABLE IF NOT EXISTS `l_config_imagens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_config_categoria_imagens` int(11) DEFAULT NULL,
  `id_config_tipo_imagens` int(11) DEFAULT NULL,
  `descricao` varchar(50) DEFAULT NULL,
  `altura` double DEFAULT NULL,
  `largura` double DEFAULT NULL,
  `max_altura` double DEFAULT NULL,
  `max_largura` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_l_config_imagens_l_config_tipo_imagens` (`id_config_categoria_imagens`),
  KEY `FK_l_config_imagens_l_config_tipo_imagens_2` (`id_config_tipo_imagens`),
  CONSTRAINT `FK_l_config_imagens_l_config_tipo_imagens` FOREIGN KEY (`id_config_categoria_imagens`) REFERENCES `l_config_categoria_imagens` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `FK_l_config_imagens_l_config_tipo_imagens_2` FOREIGN KEY (`id_config_tipo_imagens`) REFERENCES `l_config_tipo_imagens` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_config_imagens: ~5 rows (approximately)
/*!40000 ALTER TABLE `l_config_imagens` DISABLE KEYS */;
INSERT INTO `l_config_imagens` (`id`, `id_config_categoria_imagens`, `id_config_tipo_imagens`, `descricao`, `altura`, `largura`, `max_altura`, `max_largura`) VALUES
	(1, 1, 2, 'Produto Desktop', 1920, 1080, NULL, NULL),
	(2, 1, 1, 'Produto Mobile', 1920, 1080, NULL, NULL),
	(3, 1, 4, 'Produto Listagem', 1920, 1080, NULL, NULL),
	(4, 2, 2, 'Banner Desktop', 1920, 1080, NULL, NULL),
	(5, 2, 1, 'Banner Mobile', 1920, 1080, NULL, NULL);
/*!40000 ALTER TABLE `l_config_imagens` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_config_tipo_imagens
CREATE TABLE IF NOT EXISTS `l_config_tipo_imagens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_imagens` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_config_tipo_imagens: ~5 rows (approximately)
/*!40000 ALTER TABLE `l_config_tipo_imagens` DISABLE KEYS */;
INSERT INTO `l_config_tipo_imagens` (`id`, `tipo_imagens`) VALUES
	(0, 'Nenhum'),
	(1, 'Mobile'),
	(2, 'Desktop'),
	(3, 'Topo'),
	(4, 'Listagem');
/*!40000 ALTER TABLE `l_config_tipo_imagens` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_cozinhas_imagens
CREATE TABLE IF NOT EXISTS `l_cozinhas_imagens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cozinhas` int(11) DEFAULT NULL,
  `id_tipo_imagens` int(11) DEFAULT 0,
  `nome` varchar(50) DEFAULT NULL,
  `alt` varchar(50) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `ordem` int(11) DEFAULT 99,
  `visivel` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_cozinhas_imagens: ~39 rows (approximately)
/*!40000 ALTER TABLE `l_cozinhas_imagens` DISABLE KEYS */;
INSERT INTO `l_cozinhas_imagens` (`id`, `id_cozinhas`, `id_tipo_imagens`, `nome`, `alt`, `url`, `ordem`, `visivel`) VALUES
	(6, 12, 0, '9730821540', '9730821540', 'cozinhas/9730821540.webp', 99, 1),
	(7, 13, 0, '9730821540', '9730821540', 'cozinhas/9730821540.webp', 99, 1),
	(13, 9, 0, '1254653178.png', 'Cozinha 1', 'cozinhas/1254653178.png', 99, 1),
	(14, 9, 0, '190392502.png', 'Cozinha 1', 'cozinhas/190392502.png', 99, 1),
	(15, 11, 0, '481210801.png', 'Cozinha 3', 'cozinhas/481210801.png', 99, 1),
	(16, 10, 0, '116130552.png', 'Cozinha 2', 'cozinhas/116130552.png', 99, 1),
	(20, 15, 0, '2066844390.jpeg', 'Estilo Contemporâneo', 'cozinhas/2066844390.jpeg', 99, 1),
	(28, 14, 0, '1119601278.jpg', 'Estilo Clássico', 'cozinhas/1119601278.jpg', 99, 1),
	(29, 14, 0, '1068650168.jpg', 'Estilo Clássico', 'cozinhas/1068650168.jpg', 99, 1),
	(30, 14, 0, '1541495470.jpg', 'Estilo Clássico', 'cozinhas/1541495470.jpg', 99, 1),
	(31, 14, 0, '574902126.jpg', 'Estilo Clássico', 'cozinhas/574902126.jpg', 99, 1),
	(32, 14, 0, '461520524.jpg', 'Estilo Clássico', 'cozinhas/461520524.jpg', 99, 1),
	(33, 14, 0, '2021114871.jpg', 'Estilo Clássico', 'cozinhas/2021114871.jpg', 99, 1),
	(50, 17, 0, '657386056.jpg', 'Estilo Minimalista', 'cozinhas/657386056.jpg', 99, 1),
	(51, 17, 0, '1308359162.jpg', 'Estilo Minimalista', 'cozinhas/1308359162.jpg', 99, 1),
	(52, 17, 0, '744603663.jpeg', 'Estilo Minimalista', 'cozinhas/744603663.jpeg', 99, 1),
	(53, 17, 0, '1672107625.jpg', 'Estilo Minimalista', 'cozinhas/1672107625.jpg', 99, 1),
	(54, 17, 0, '701223780.jpg', 'Estilo Minimalista', 'cozinhas/701223780.jpg', 99, 1),
	(55, 17, 0, '1544423659.jpg', 'Estilo Minimalista', 'cozinhas/1544423659.jpg', 99, 1),
	(56, 17, 0, '1604802618.jpg', 'Estilo Minimalista', 'cozinhas/1604802618.jpg', 99, 1),
	(57, 17, 0, '1408529892.jpg', 'Estilo Minimalista', 'cozinhas/1408529892.jpg', 99, 1),
	(58, 17, 0, '1111561845.jpg', 'Estilo Minimalista', 'cozinhas/1111561845.jpg', 99, 1),
	(59, 16, 0, '1715550751.jpg', 'Estilo Industrial', 'cozinhas/1715550751.jpg', 99, 1),
	(60, 16, 0, '1124235952.jpg', 'Estilo Industrial', 'cozinhas/1124235952.jpg', 99, 1),
	(61, 16, 0, '652241445.jpg', 'Estilo Industrial', 'cozinhas/652241445.jpg', 99, 1),
	(62, 16, 0, '1125918997.jpg', 'Estilo Industrial', 'cozinhas/1125918997.jpg', 99, 1),
	(63, 18, 0, '1809838068.jpeg', 'Estilo Moderno', 'cozinhas/1809838068.jpeg', 99, 1),
	(64, 18, 0, '1456411680.jpg', 'Estilo Moderno', 'cozinhas/1456411680.jpg', 99, 1),
	(65, 18, 0, '624008594.jpeg', 'Estilo Moderno', 'cozinhas/624008594.jpeg', 99, 1),
	(66, 18, 0, '412720700.jpg', 'Estilo Moderno', 'cozinhas/412720700.jpg', 99, 1),
	(67, 18, 0, '462511184.jpg', 'Estilo Moderno', 'cozinhas/462511184.jpg', 99, 1),
	(68, 18, 0, '68884598.jpg', 'Estilo Moderno', 'cozinhas/68884598.jpg', 99, 1),
	(69, 18, 0, '1590421975.jpg', 'Estilo Moderno', 'cozinhas/1590421975.jpg', 99, 1),
	(70, 18, 0, '1373970671.jpg', 'Estilo Moderno', 'cozinhas/1373970671.jpg', 99, 1),
	(71, 18, 0, '1133616131.jpg', 'Estilo Moderno', 'cozinhas/1133616131.jpg', 99, 1),
	(72, 18, 0, '1045419649.jpg', 'Estilo Moderno', 'cozinhas/1045419649.jpg', 99, 1),
	(73, 18, 0, '1826866370.jpg', 'Estilo Moderno', 'cozinhas/1826866370.jpg', 99, 1),
	(76, 15, 0, '1262746106.jpg', 'Estilo Contemporâneo', 'cozinhas/1262746106.jpg', 99, 1);
/*!40000 ALTER TABLE `l_cozinhas_imagens` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_cozinhas_pt
CREATE TABLE IF NOT EXISTS `l_cozinhas_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` int(11) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `destaque` int(11) DEFAULT 0,
  `visivel` int(11) DEFAULT 1,
  `ordem` int(11) DEFAULT 99,
  PRIMARY KEY (`id`),
  KEY `FK_l_cozinhas_pt_l_categorias_pt` (`id_categoria`),
  CONSTRAINT `FK_l_cozinhas_pt_l_categorias_pt` FOREIGN KEY (`id_categoria`) REFERENCES `l_categorias_pt` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_cozinhas_pt: ~5 rows (approximately)
/*!40000 ALTER TABLE `l_cozinhas_pt` DISABLE KEYS */;
INSERT INTO `l_cozinhas_pt` (`id`, `id_categoria`, `nome`, `titulo`, `descricao`, `imagem`, `title`, `description`, `keywords`, `url`, `destaque`, `visivel`, `ordem`) VALUES
	(14, 17, 'Estilo Clássico', NULL, '<p>O estilo Clássico oferece visualmente um espaço minimalista e limpo.&nbsp;</p><p>O mobiliário marca o estilo com toques tradicionais, versáteis e elementos decorativos.</p><p>Este estilo caracteriza-se pela seleção de armários de cozinha de cor branca ou creme,com detalhes arquitetônicos simples e detalhes de cor.</p><p><br>&nbsp;</p>', NULL, NULL, NULL, NULL, 'sven', 0, 1, NULL),
	(15, 18, 'Estilo Contemporâneo', NULL, '<p>O estilo contemporâneo reflete uma mistura do novo e antigo, do casual e sofisticado para a sua cozinha. Para diferenciar este estilo, geralmente temos integrado assentos confortáveis, espaços abertos, que permitem uma maior interação entre cozinheiros e convidados. Contamos com linhas horizontais fortes, acabamentos e decorações divertidas. Este estilo proporciona um ambiente envolvente elegante, minimalista, moderno e futurista apoiado em novas tendências de design e tecnologia.</p>', NULL, NULL, NULL, NULL, 'estilo_contemporaneo', 0, 1, NULL),
	(16, 19, 'Estilo Industrial', NULL, '<p>O estilo industrial caracteriza-se pela exposição de tijolos brutos e estruturas, tubos de água, vigas de metal, decorações e acessórios industriais.&nbsp;</p><p>Apresenta-se como um conceito de espaço aberto e a iluminação mais escura. Trata-se de um estilo charmoso para o seu projeto de cozinha, mas comparativamente com os estilos apresentados revela-se o menos aconchegante.</p><p><br>&nbsp;</p>', NULL, NULL, NULL, NULL, 'estilo_industrial', 0, 1, NULL),
	(17, 20, 'Estilo Minimalista', NULL, '<p>No estilo minimalista, “menos é mais”. Com este estilo podemos ter um espaço limpo, em que apenas importa o necessário, ou seja, nenhum detalhe desnecessário é permitido. Este registo conta com armários inferiores e superiores, painéis de porta sólidos, segue-se a otimização de cada canto com o propósito de usufruir de uma maior capacidade de armazenamento. No estilo minimalista aplicam-se paletas de cores monocromáticas simples.</p>', NULL, NULL, NULL, NULL, 'estilo_minimalista', 0, 1, NULL),
	(18, 21, 'Estilo Moderno', NULL, '<p>Uma cozinha, estilo moderno incorpora sofisticação e atratividade. No que diz respeito ao design são utilizadas linhas limpas e atemporais. As bancadas polidas são acentuadas com toques de cor para enfatizar o design e o material de alta qualidade. Os materiais de elevada qualidade são características distintivas das cozinhas modernas, incluindo materiais exóticos, visualmente luxuosos o que também é perceptível ao toque.</p>', NULL, NULL, NULL, NULL, 'estilo_moderno', 0, 1, NULL);
/*!40000 ALTER TABLE `l_cozinhas_pt` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_materiais_imagens
CREATE TABLE IF NOT EXISTS `l_materiais_imagens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_materiais` int(11) DEFAULT NULL,
  `id_tipo_imagens` int(11) DEFAULT 0,
  `nome` varchar(50) DEFAULT NULL,
  `alt` varchar(50) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `ordem` int(11) DEFAULT 99,
  `visivel` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `FK_l_materiais_imagens_l_materiais_pt` (`id_materiais`),
  KEY `FK_l_materiais_imagens_l_config_tipo_imagens` (`id_tipo_imagens`)
) ENGINE=MyISAM AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_materiais_imagens: 68 rows
/*!40000 ALTER TABLE `l_materiais_imagens` DISABLE KEYS */;
INSERT INTO `l_materiais_imagens` (`id`, `id_materiais`, `id_tipo_imagens`, `nome`, `alt`, `url`, `ordem`, `visivel`) VALUES
	(22, 2, 0, '1407438615.jpg', 'Fénix', 'materiais/1407438615.jpg', 99, 1),
	(21, 2, 0, '121014002.jpg', 'Fénix', 'materiais/121014002.jpg', 99, 1),
	(20, 2, 0, '1409403644.jpg', 'Fénix', 'materiais/1409403644.jpg', 99, 1),
	(19, 2, 0, '1143795749.jpg', 'Fénix', 'materiais/1143795749.jpg', 99, 1),
	(26, 3, 0, '1691579335.jpg', 'Lacado', 'materiais/1691579335.jpg', 99, 1),
	(25, 3, 0, '1751745020.jpg', 'Lacado', 'materiais/1751745020.jpg', 99, 1),
	(8, 1, 0, '1098787860.jpg', 'Estratificado', 'materiais/1098787860.jpg', 99, 1),
	(9, 1, 0, '1597871194.jpg', 'Estratificado', 'materiais/1597871194.jpg', 99, 1),
	(10, 1, 0, '907576658.jpg', 'Estratificado', 'materiais/907576658.jpg', 99, 1),
	(11, 1, 0, '1653245029.jpg', 'Estratificado', 'materiais/1653245029.jpg', 99, 1),
	(12, 1, 0, '1320442936.jpg', 'Estratificado', 'materiais/1320442936.jpg', 99, 1),
	(13, 1, 0, '702309901.jpg', 'Estratificado', 'materiais/702309901.jpg', 99, 1),
	(14, 1, 0, '1082152762.jpg', 'Estratificado', 'materiais/1082152762.jpg', 99, 1),
	(15, 1, 0, '626988606.jpg', 'Estratificado', 'materiais/626988606.jpg', 99, 1),
	(16, 1, 0, '140999383.jpg', 'Estratificado', 'materiais/140999383.jpg', 99, 1),
	(17, 1, 0, '336179764.jpg', 'Estratificado', 'materiais/336179764.jpg', 99, 1),
	(18, 1, 0, '1527742868.jpg', 'Estratificado', 'materiais/1527742868.jpg', 99, 1),
	(23, 2, 0, '1077616257.jpg', 'Fénix', 'materiais/1077616257.jpg', 99, 1),
	(24, 2, 0, '1590072776.jpg', 'Fénix', 'materiais/1590072776.jpg', 99, 1),
	(27, 3, 0, '767844814.jpg', 'Lacado', 'materiais/767844814.jpg', 99, 1),
	(28, 3, 0, '1628247827.jpg', 'Lacado', 'materiais/1628247827.jpg', 99, 1),
	(29, 3, 0, '631666108.jpg', 'Lacado', 'materiais/631666108.jpg', 99, 1),
	(30, 3, 0, '1525285782.jpg', 'Lacado', 'materiais/1525285782.jpg', 99, 1),
	(31, 3, 0, '1970088988.jpg', 'Lacado', 'materiais/1970088988.jpg', 99, 1),
	(32, 3, 0, '1461257278.jpg', 'Lacado', 'materiais/1461257278.jpg', 99, 1),
	(33, 3, 0, '120934032.jpg', 'Lacado', 'materiais/120934032.jpg', 99, 1),
	(34, 3, 0, '874080510.jpg', 'Lacado', 'materiais/874080510.jpg', 99, 1),
	(35, 3, 0, '822723.jpg', 'Lacado', 'materiais/822723.jpg', 99, 1),
	(36, 3, 0, '1006578531.jpg', 'Lacado', 'materiais/1006578531.jpg', 99, 1),
	(37, 3, 0, '35390768.jpg', 'Lacado', 'materiais/35390768.jpg', 99, 1),
	(38, 3, 0, '1522775930.jpg', 'Lacado', 'materiais/1522775930.jpg', 99, 1),
	(39, 3, 0, '234796407.jpg', 'Lacado', 'materiais/234796407.jpg', 99, 1),
	(40, 3, 0, '1444405225.jpg', 'Lacado', 'materiais/1444405225.jpg', 99, 1),
	(41, 4, 0, '1840531975.jpg', 'Madeira Carbonizada', 'materiais/1840531975.jpg', 99, 1),
	(42, 4, 0, '2053354377.jpg', 'Madeira Carbonizada', 'materiais/2053354377.jpg', 99, 1),
	(43, 4, 0, '1718040516.jpg', 'Madeira Carbonizada', 'materiais/1718040516.jpg', 99, 1),
	(44, 4, 0, '1777747959.jpg', 'Madeira Carbonizada', 'materiais/1777747959.jpg', 99, 1),
	(45, 4, 0, '1416214510.jpg', 'Madeira Carbonizada', 'materiais/1416214510.jpg', 99, 1),
	(46, 4, 0, '1120575798.jpg', 'Madeira Carbonizada', 'materiais/1120575798.jpg', 99, 1),
	(47, 4, 0, '79235377.jpg', 'Madeira Carbonizada', 'materiais/79235377.jpg', 99, 1),
	(48, 4, 0, '1835909919.jpg', 'Madeira Carbonizada', 'materiais/1835909919.jpg', 99, 1),
	(49, 4, 0, '1645543572.jpg', 'Madeira Carbonizada', 'materiais/1645543572.jpg', 99, 1),
	(50, 5, 0, '474487918.jpg', 'Madeiras', 'materiais/474487918.jpg', 99, 1),
	(51, 5, 0, '805495533.jpg', 'Madeiras', 'materiais/805495533.jpg', 99, 1),
	(52, 5, 0, '1306411376.jpg', 'Madeiras', 'materiais/1306411376.jpg', 99, 1),
	(53, 5, 0, '573790507.jpg', 'Madeiras', 'materiais/573790507.jpg', 99, 1),
	(54, 6, 0, '828846362.jpeg', 'Melaminas', 'materiais/828846362.jpeg', 99, 1),
	(55, 6, 0, '1685021669.jpeg', 'Melaminas', 'materiais/1685021669.jpeg', 99, 1),
	(56, 6, 0, '473132634.jpeg', 'Melaminas', 'materiais/473132634.jpeg', 99, 1),
	(57, 6, 0, '1906095936.jpeg', 'Melaminas', 'materiais/1906095936.jpeg', 99, 1),
	(58, 6, 0, '1020904868.jpeg', 'Melaminas', 'materiais/1020904868.jpeg', 99, 1),
	(59, 6, 0, '641831890.jpeg', 'Melaminas', 'materiais/641831890.jpeg', 99, 1),
	(60, 6, 0, '2124850895.jpeg', 'Melaminas', 'materiais/2124850895.jpeg', 99, 1),
	(61, 6, 0, '274071752.jpeg', 'Melaminas', 'materiais/274071752.jpeg', 99, 1),
	(62, 6, 0, '1146905327.jpeg', 'Melaminas', 'materiais/1146905327.jpeg', 99, 1),
	(63, 6, 0, '455563543.jpg', 'Melaminas', 'materiais/455563543.jpg', 99, 1),
	(64, 6, 0, '2028106083.jpg', 'Melaminas', 'materiais/2028106083.jpg', 99, 1),
	(65, 6, 0, '658140097.jpg', 'Melaminas', 'materiais/658140097.jpg', 99, 1),
	(66, 6, 0, '1794476483.jpg', 'Melaminas', 'materiais/1794476483.jpg', 99, 1),
	(67, 7, 0, '961666132.jpg', 'Vidro', 'materiais/961666132.jpg', 99, 1),
	(68, 7, 0, '955941194.jpg', 'Vidro', 'materiais/955941194.jpg', 99, 1),
	(69, 7, 0, '1713846977.jpg', 'Vidro', 'materiais/1713846977.jpg', 99, 1),
	(70, 7, 0, '1187207661.jpg', 'Vidro', 'materiais/1187207661.jpg', 99, 1),
	(71, 7, 0, '1077361559.jpg', 'Vidro', 'materiais/1077361559.jpg', 99, 1),
	(72, 7, 0, '1874055715.jpg', 'Vidro', 'materiais/1874055715.jpg', 99, 1),
	(73, 7, 0, '1817480178.jpg', 'Vidro', 'materiais/1817480178.jpg', 99, 1),
	(74, 7, 0, '329340322.jpg', 'Vidro', 'materiais/329340322.jpg', 99, 1),
	(75, 7, 0, '1437466217.jpg', 'Vidro', 'materiais/1437466217.jpg', 99, 1);
/*!40000 ALTER TABLE `l_materiais_imagens` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_materiais_pt
CREATE TABLE IF NOT EXISTS `l_materiais_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` int(11) DEFAULT NULL,
  `nome` varchar(50) NOT NULL,
  `descricao` text NOT NULL,
  `imagem` varchar(255) NOT NULL DEFAULT '',
  `visivel` int(11) DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `ordem` int(2) NOT NULL DEFAULT 99,
  PRIMARY KEY (`id`),
  KEY `FK_l_materiais_pt_l_categorias_pt` (`id_categoria`),
  CONSTRAINT `FK_l_materiais_pt_l_categorias_pt` FOREIGN KEY (`id_categoria`) REFERENCES `l_categorias_pt` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_materiais_pt: ~7 rows (approximately)
/*!40000 ALTER TABLE `l_materiais_pt` DISABLE KEYS */;
INSERT INTO `l_materiais_pt` (`id`, `id_categoria`, `nome`, `descricao`, `imagem`, `visivel`, `url`, `ordem`) VALUES
	(1, 22, 'Estratificado', '<p>O material estratificado permite uma maior resistência à água e aos riscos, garante também mais higienização. Dispomos deste material em várias cores e acabamentos. Consiga a manutenção, estética e facilidade de uso que procura.</p>', 'materiais/399230681.webp', 1, 'estratificado', 99),
	(2, 23, 'Fénix', '<p>O Fénix é um material inovador, com aspeto mate e oferece um desempenho de ponta. Dadas as características de superfície, permite o reparo térmico de marcas e um toque sedoso graças à utilização de nanotecnologias.</p>', 'materiais/80596526.webp', 1, 'fenix', 99),
	(3, 24, 'Lacado', '<p>O seu projeto cozinha Lacada como desejar, na cor que mais gostar e com os acabamentos com o efeito que pretender. O material lacado garante superfícies e bordas de alta qualidade com forte resistência a marcas e impactos.</p>', 'materiais/524052292.webp', 1, 'lacado', 99),
	(4, 25, 'Madeira Carbonizada', '<p>A madeira carbonizada é o resultado da inspiração em antigas tradições japonesas. A madeira carbonizada com  uma camada de carvão única visível na cor e textura que ficam na madeira.</p><p>Os tipos de madeira tratada possuem a sua própria estrutura e aplicações. A madeira carbonizada é aplicada em revestimento de fachadas, decoração de interiores, mobiliário e entre outros.</p>\r\n', 'materiais/346865528.webp', 1, 'madeira_carbonizada', 99),
	(5, 26, 'Madeiras', '<p>As portas de madeira são o resultado de uma tecnologia de produção avançada que garante a sua estabilidade ao longo do tempo.</p><p>Este material proporciona um encanto natural. Pode escolher a cor que deseja, temos várias opções de folheados e carvalho à sua disposição.</p>', 'materiais/1563720523.webp', 1, 'madeiras', 99),
	(6, 27, 'Melaminas', '<p>A melamina é um material inovador, oferece qualidades de superfície e visuais a um preço acessível.</p><p>O acabamento das portas atesta mais durabilidade e impermeabilização. Pode optar por variados acabamentos.</p>\r\n', 'materiais/524220956.webp', 1, 'melaminas', 99),
	(7, 28, 'Vidro', '<p>O vidro traz mais luz e reflexo ao seu projeto cozinha.</p>', 'materiais/587955722.webp', 1, 'vidro', 99);
/*!40000 ALTER TABLE `l_materiais_pt` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_newsletter_pt
CREATE TABLE IF NOT EXISTS `l_newsletter_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_lista` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `data_registo` date DEFAULT NULL,
  `data_remocao` date DEFAULT NULL,
  `aceitar` int(11) DEFAULT 0,
  `ativo` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_newsletter_pt: ~3 rows (approximately)
/*!40000 ALTER TABLE `l_newsletter_pt` DISABLE KEYS */;
INSERT INTO `l_newsletter_pt` (`id`, `id_lista`, `email`, `data_registo`, `data_remocao`, `aceitar`, `ativo`) VALUES
	(1, 16, 'adriano.araujo@netgocio.pt', '2020-06-01', NULL, 0, 0),
	(2, NULL, 'analista.sistemas@netgocio.pt', '2021-06-28', NULL, 0, 0),
	(3, NULL, 'marketing@cozinhaspl.com', '2021-07-13', NULL, 0, 0),
	(4, NULL, 'projects@netgocio.pt', '2021-07-30', NULL, 0, 0),
	(5, NULL, 'cristiana76ferreira@hotmail.com', '2021-08-03', NULL, 0, 0);
/*!40000 ALTER TABLE `l_newsletter_pt` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_noticias_imagens
CREATE TABLE IF NOT EXISTS `l_noticias_imagens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_noticias` int(11) DEFAULT NULL,
  `id_tipo_imagens` int(11) DEFAULT 0,
  `nome` varchar(255) DEFAULT NULL,
  `alt` varchar(255) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `ordem` int(11) DEFAULT 99,
  `visivel` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `FK_l_noticias_imagens_l_noticias_pt` (`id_noticias`),
  KEY `FK_l_noticias_imagens_l_config_tipo_imagens` (`id_tipo_imagens`),
  CONSTRAINT `FK_l_noticias_imagens_l_config_tipo_imagens` FOREIGN KEY (`id_tipo_imagens`) REFERENCES `l_config_tipo_imagens` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `FK_l_noticias_imagens_l_noticias_pt` FOREIGN KEY (`id_noticias`) REFERENCES `l_noticias_pt` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_noticias_imagens: ~0 rows (approximately)
/*!40000 ALTER TABLE `l_noticias_imagens` DISABLE KEYS */;
/*!40000 ALTER TABLE `l_noticias_imagens` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_noticias_pt
CREATE TABLE IF NOT EXISTS `l_noticias_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` int(11) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `subtitulo` varchar(255) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `resumo` varchar(100) DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `ficheiro` varchar(255) NOT NULL,
  `data` date DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `visivel` int(11) DEFAULT 1,
  `ordem` int(11) DEFAULT 99,
  `destaque` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_l_noticias_pt_l_categorias_pt` (`id_categoria`),
  CONSTRAINT `FK_l_noticias_pt_l_categorias_pt` FOREIGN KEY (`id_categoria`) REFERENCES `l_categorias_pt` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_noticias_pt: ~4 rows (approximately)
/*!40000 ALTER TABLE `l_noticias_pt` DISABLE KEYS */;
INSERT INTO `l_noticias_pt` (`id`, `id_categoria`, `titulo`, `subtitulo`, `descricao`, `resumo`, `imagem`, `ficheiro`, `data`, `title`, `description`, `keywords`, `url`, `visivel`, `ordem`, `destaque`) VALUES
	(1, 14, 'Madeira Carbonizada', 'asdfasdf', '<p>Atualizamos o catálogo de materiais e incluímos a madeira carbonizada. A técnica de carbonização é inspirada numa tradição japonesa milenar.  Este material é aplicado em design de interiores, mobiliário, revestimento de fachadas, entre outros.</p><p>A tendência veio para ficar, corresponde ao desejo dos clientes que adoram o novo e amam o diferente.</p>\r\n', 'A tendência veio para ficar, corresponde ao desejo dos clientes que adoram o novo e amam o diferente', 'noticias/296580331.webp', '', '2021-06-09', NULL, NULL, NULL, 'madeira_carbonizada', 1, NULL, 1),
	(2, 14, 'Inovação do processo produtivo', 'Subtítulo', '<p>De um modo geral tem-se registado um aumento da procura no setor mobiliário especializado em cozinhas. Firmou-se necessário inovar o processo produtivo da empresa tornando-o ainda mais flexível e rápido. Com a integração de uma orladora a laser vimos melhorada a capacidade produtiva e a qualidade do acabamento do produto final.</p><p>A orladora a laser oferece uma combinação única para painéis de processamento com dois sistemas para juntas perfeitamente invisíveis. O sistema de aplicação de cola GluJet para o uso padrão de cola PUR e o LTRONIC, a nova unidade de afiação a laser do HOLZ-HER, são imbatíveis em termos de velocidade.</p><p>Até 18 servo-eixos NC fornecem automação máxima e produtividade. Desde o corte de articulação de alta tecnologia até ao acabamento completo, esta máquina oferece equipamentos abrangentes para banda de borda perfeita.</p>', 'De um modo geral tem-se registado um aumento da procura no setor mobiliário especializado em cozinha', 'noticias/2037310628.webp', '', '2021-06-24', NULL, NULL, NULL, 'inovacao_do_processo_produtivo', 1, NULL, 1),
	(3, 14, 'Renovação Showroom Cozinhas PL', ' ', '<p>Brevemente…</p><p>Renovação Showroom Cozinhas PL</p><p>Ampliamos o nosso showroom para lhe dar a conhecer novos projetos, materiais, diferentes estilos, novos designs e cores.</p><p>Conheça em breve as mais recentes novidades e tendências para o seu novo projeto de cozinha.</p>\r\n', 'Ampliamos o nosso showroom para lhe dar a conhecer novos projetos, materiais, diferentes estilos, no', 'noticias/602892672.webp', '', NULL, NULL, NULL, NULL, 'renovacao_showroom_cozinhas_pl', 1, NULL, 0),
	(8, 14, 'Cozinhas PL: Revista Caras Decoração edição de Abril 2021', ' ', '<p>Partilhamos uma combinação perfeita de design, funcionalidade e qualidade na edição de Abril 2021 da revista Caras Decoração. Descubra já!</p>', 'Combinação perfeita de design e funcionalidades', 'noticias/694562587.webp', '', '2021-06-23', NULL, NULL, NULL, 'cozinhas_pl_revista_caras_decoracao_edicao_de_abril_2021', 1, NULL, 1);
/*!40000 ALTER TABLE `l_noticias_pt` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_notificacao_pt
CREATE TABLE IF NOT EXISTS `l_notificacao_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cc` varchar(255) DEFAULT NULL,
  `bcc` varchar(255) DEFAULT NULL,
  `assunto_admin` varchar(255) DEFAULT NULL,
  `assunto_cliente` varchar(255) DEFAULT NULL,
  `txt_sucesso_preenchimento` varchar(255) DEFAULT NULL,
  `descricao_admin` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_notificacao_pt: ~2 rows (approximately)
/*!40000 ALTER TABLE `l_notificacao_pt` DISABLE KEYS */;
INSERT INTO `l_notificacao_pt` (`id`, `titulo`, `email`, `cc`, `bcc`, `assunto_admin`, `assunto_cliente`, `txt_sucesso_preenchimento`, `descricao_admin`) VALUES
	(1, 'form 1', '1', '2', '3', '4', '5', '6', '<p>7</p>'),
	(2, '1', '2', '3', '4', '5', '6', '7', '<p>8</p>');
/*!40000 ALTER TABLE `l_notificacao_pt` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_paginas_config
CREATE TABLE IF NOT EXISTS `l_paginas_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) DEFAULT NULL,
  `texto` text DEFAULT NULL,
  `ref` varchar(50) DEFAULT NULL,
  `imagem` varchar(50) DEFAULT NULL,
  `banner_footer` int(1) NOT NULL,
  `banner_imagem` varchar(50) DEFAULT NULL,
  `banner_titulo` varchar(50) DEFAULT NULL,
  `banner_texto` text DEFAULT NULL,
  `banner_botao_texto` varchar(50) DEFAULT NULL,
  `banner_botao_externo` int(1) DEFAULT NULL,
  `banner_botao_url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_paginas_config: ~5 rows (approximately)
/*!40000 ALTER TABLE `l_paginas_config` DISABLE KEYS */;
INSERT INTO `l_paginas_config` (`id`, `titulo`, `texto`, `ref`, `imagem`, `banner_footer`, `banner_imagem`, `banner_titulo`, `banner_texto`, `banner_botao_texto`, `banner_botao_externo`, `banner_botao_url`) VALUES
	(1, 'Cozinhas', 'A cozinha é um espaço central do nosso lar, onde passamos a maior parte do nosso tempo. Esta divisão caracteriza-se por ser um local de partilha de momentos, que eternizamos. A escolha de um estilo para a sua cozinha dependerá do seu estilo pessoal, do espaço disponível, do design da sua casa, entre outros.  \n\nA seleção de um estilo pode tornar-se complexa, por isso, reunimos um conjunto de diferentes estilos e oferecemos aconselhamento profissionalizado.', 'cozinhas', NULL, 1, 'cozinhas/6503466312.webp', 'Os Nossos Projetos', 'Os nossos projetos reais, podem tornar-se numa fonte de inspiração para si. Para isso, resolvemos partilhar alguns projetos consigo para que possa ter ideias para o seu projeto Cozinha.', 'Explorar', NULL, 'projetos'),
	(2, 'Projetos', 'Os nossos projetos reais, podem tornar-se numa fonte de inspiração para si. \n\nPara isso, resolvemos partilhar alguns projetos consigo para que possa ter ideias para o seu projeto Cozinha. Oferecemos também aconselhamento profissional na criação do seu projeto cozinha. Primamos as suas ideias e a sua concretização o mais fielmente possível.', 'projetos', NULL, 0, 'projetos/8128890275.webp', '1', '2', '3', NULL, '4'),
	(3, 'Materiais', 'Para o nosso fabrico apenas selecionamos materiais de qualidade. Conheça a vasta oferta que temos ao seu dispor.', 'materiais', 'materiais/13006950896.webp', 1, 'materiais/6503475444.webp', 'Personalizações', 'Conheça as soluções ideais para os interiores dos móveis de cozinha dos seus projetos. Melhore o acesso ao interior do armário, para que o necessário esteja sempre à mão.\n\nConsiga mais espaço para o armazenamento e aproveite os cantos esquecidos do seu projeto cozinha.\n\nOs pequenos espaços darão origem a armários estreitos o que significa mais áreas de arrumações para os seus projetos.', 'Explorar', NULL, 'personalizacoes'),
	(4, 'Personalizações', '', 'personalizacoes', NULL, 0, 'personalizacoes/11380448436.webp', '1', '2', '3', NULL, '4'),
	(5, 'Catálogos', 'teste catálogos', 'catalogos', NULL, 1, 'catalogos/14632005042.webp', '1', '2', '3', NULL, '4');
/*!40000 ALTER TABLE `l_paginas_config` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_paginas_pt
CREATE TABLE IF NOT EXISTS `l_paginas_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` int(11) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `ref` varchar(50) DEFAULT NULL,
  `subtitulo` varchar(255) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `destaque` int(11) DEFAULT 0,
  `keywords` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `visivel` int(1) DEFAULT 1,
  `visivelFooter` int(1) DEFAULT 1,
  `ordem` int(11) DEFAULT 99,
  `mostrar_topo` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_l_paginas_pt_l_categorias_pt` (`id_categoria`),
  CONSTRAINT `FK_l_paginas_pt_l_categorias_pt` FOREIGN KEY (`id_categoria`) REFERENCES `l_categorias_pt` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_paginas_pt: ~13 rows (approximately)
/*!40000 ALTER TABLE `l_paginas_pt` DISABLE KEYS */;
INSERT INTO `l_paginas_pt` (`id`, `id_categoria`, `titulo`, `ref`, `subtitulo`, `descricao`, `imagem`, `data`, `title`, `description`, `destaque`, `keywords`, `url`, `visivel`, `visivelFooter`, `ordem`, `mostrar_topo`) VALUES
	(1, 15, 'Sobre nós', NULL, 'asdfasdf', '<p>Nascemos como empresa pelas mãos de António Augusto Leite, graças à sua sabedoria adquirida ao longo dos anos e paixão pelo setor.</p><p>As Cozinhas PL são fruto da experiência, da dedicação, know-how de António Augusto Leite e dos seus filhos Rafael Leite e Nicolas Leite.</p><p>Assumimos compromissos que são prioritários ao longo dos anos, nomeadamente, a garantia de qualidade, proporcionando elevados níveis de satisfação aos nossos clientes, com a prestação de um serviço personalizado, profissional, responsável, inovador e de confiança.</p><p>Cada cliente é único, e o nosso serviço é altamente personalizado para dar a melhor resposta às diferentes necessidades.</p><p>Ao longo dos anos continuaremos a investir na inovação da formação dos nossos colaboradores e dos serviços prestados.</p><p>&nbsp;</p><h2><strong>TIMELINE:</strong></h2><p>&nbsp;</p><p>&nbsp;</p><ul><li>1986</li></ul><p>Nascimento da empresa Cozinhas PL, pelas mãos de António Augusto Leite.</p><p>&nbsp;</p><ul><li>2012</li></ul><p>Dada a expansão internacional e o aumento da procura no setor a empresa passou de uma área de fabrico de 150m2 para uma área de 800m2 na Zona Industrial de Fafe.</p><p>&nbsp;</p><ul><li>2014</li></ul><p>1º Projeto internacionalização: Expansão internacional que contou com a presença na: Foire International de Bourdeux, Foire Print enps e Foite international Lyon.</p><p>&nbsp;</p><ul><li>2016/2017</li></ul><p>A empresa sentiu a necessidade de alargar as suas instalações e mudar-se novamente para um novo pavilhão com 2,000m2 em Antime, Fafe. A empresa certifica-se como empresa de qualidade pela norma ISO 9001 com o objetivo de elevar o nível de satisfação dos seus clientes.</p><p>&nbsp;</p><ul><li>2019</li></ul><p>- Inovação no processo produtivo com a aquisição da orladora Holz, Lumina L-Tronic que resulta numa melhor qualidade de acabamento e colagem a laser.</p><p>- 2º Projeto internacionalização: Expansão internacional que contou com a presença na Foire D´Atommne-Paris.</p><p>&nbsp;</p><ul><li>2020</li></ul><p>Ainda com uma conjuntura pandémica o ano revelou-se próspero. Tornou-se necessário aumentar a capacidade produtiva e para tal integrar uma nova CNC vertical Holz Her.</p><p>&nbsp;</p><ul><li>2021</li></ul><p>Novo Showroom com muitas novidades em relação ao design, personalização e inovação.</p><p><br>&nbsp;</p><p><br>&nbsp;</p><p><br>&nbsp;</p>', NULL, '2021-05-25', 'Sobre nós', 'Página sobre', 0, NULL, 'sobre_nos', 1, 0, 1, 0),
	(2, 15, 'Política de Privacidade', NULL, 'sadfsdf', '<p><strong>Última atualização</strong>: 08/04/2021</p><p>A presente Política de Privacidade regula o tratamento de dados de carácter pessoal realizado no website www.cozinhaspl.com (doravante também designado por "website").</p><p>O utilizador do website deve ler atentamente a presente Política de Privacidade sempre que se propuser utilizar o website, já que esta pode sofrer modificações sem aviso prévio (verifique a data da atualização no início do texto).</p><p><strong>1.Definição</strong></p><p>1.1 Por dados pessoais deve ser entendida a informação, de qualquer natureza e suporte, incluindo-se o som e imagem, relativa a uma pessoa singular identificada ou identificável. É considerada como identificável uma pessoa que possa ser identificada, direta ou indiretamente, designadamente por referência a um número de identificação ou a um ou mais elementos específicos da sua identidade física, fisiológica, psíquica, económica, cultural ou social.</p><p><strong>2.Responsável pelo tratamento e Autoridade de controlo nacional</strong></p><p>2.1 A entidade responsável pela recolha e tratamento dos dados pessoais dos utilizadores, designadamente, pelas categorias de dados recolhidos, qual o tratamento dos mesmos e as finalidades para que são utilizados é a empresa Cozinhas PL- comércio e instalação de cozinhas, LDA., nº de contribuinte 505692210 Sede Rua da Cepeda, Nº 8, 4820-202 Fafe, telefone nº+351 253 495 326, email rgpd@cozinhaspl.com.</p><p><strong>2.2 Autoridade de controlo nacional</strong></p><p>A autoridade de controlo nacional é a Comissão nacional de Proteção de dados (CNPD):</p><p>Rua de São Bento, nº 148, 3º</p><p>1200-821 LISBOA</p><p>geral@cnpd.pt</p><p><strong>3. Tipos de dados pessoais e finalidades do tratamento</strong></p><p>3.1 Acesso ao website e navegação: com o acesso ao website são recolhidos de forma automática um conjunto de dados informáticos, que são gravados de forma temporária em ficheiros próprios, sendo eliminados de forma também automática após determinado período. A recolha destes dados tem objetivos meramente técnicos, como sejam a configuração da ligação, a segurança do sistema, a administração técnica da rede e a otimização do website. São os seguintes, os dados pessoais recolhidos com esta finalidade: a) Endereço IP do processador requerente; b) Data e hora de acesso; c) Nome e URL do ficheiro transferido; d) Volume dos dados transmitidos; e) Indicação sobre se a transferência foi efetuada com êxito; f) Dados de identificação do software do navegador e do sistema operativo; g) Website a partir do qual acedeu ao nosso website; h) Nome do fornecedor de serviço de Internet.</p><p>3.2 Formulário de contacto: se pretender contactar Cozinhas PL, diretamente através do website, deverá preencher o formulário disponibilizado para o efeito, que poderá ser encontrado no menu em “Contactos”. Ser-lhe-ão solicitados alguns dados pessoais como o nome, endereço de email e localidade. A recolha destes dados visa apenas tornar possível responder ao seu pedido e prestar-lhe as informações de que necessitar.</p><p>3.3 Newsletters: a Cozinhas PL disponibiliza a possibilidade de subscrição de um serviço gratuito de newsletters aos visitantes do seu website. A finalidade deste serviço visa levar ao conhecimento dos seus subscritores informação relevante dentro das áreas de interesse abrangidas pelos serviços prestados pela Cozinhas PL. Para poder usufruir deste serviço terá necessariamente que fornecer o seu endereço de email. Poderá cancelar a subscrição do serviço das newsletters a todo o tempo, bastando, para o feito, seguir as indicações nesse sentido presentes no final de cada newsletter.</p><p>3.4 O Utilizador garante que os dados pessoais facultados à Cozinhas PL são verdadeiros e torna-se responsável por comunicar qualquer alteração dos mesmos.</p><p><strong>4. Fornecimento de dados a terceiros</strong></p><p>4.1 Os seus dados pessoais poderão ser divulgados a terceiros prestadores de serviços que auxiliem a Cozinhas PL no exercício da sua atividade tais como serviços de alojamento de página web, gestão de marca e promoções de produtos. Na medida do possível, a Cozinhas PL procura garantir que as entidades que têm acesso aos dados pessoais são credíveis e oferecem elevadas garantias de proteção, nunca lhes sendo transmitidos dados para além do necessário à prestação do serviço contratado.</p><p>4.2 Além disso, os seus dados pessoais poderão ser divulgados a terceiros, para: Satisfazer exigências impostas pela lei ou pelas autoridades governamentais ou judiciais competentes; Satisfazer exigências necessárias para instaurar ou sustentar um processo judicial ou a defesa numa ação judicial;</p><p>Os seus dados pessoais poderão também ser comunicados à polícia ou às autoridades judiciais, em conformidade com as leis e regulamentos aplicáveis e mediante um pedido formal por parte das autoridades, para efeitos de prevenção de fraude contra nós (serviços anti-fraude).</p><p><strong>5. Período de conservação dos seus dados</strong></p><p>Os seus dados pessoais serão conservados pelo prazo necessário ao cumprimento de obrigações legais. Na ausência de exigência legal específica, os dados pessoais do utilizador serão armazenados e conservados pelo prazo necessário para efeitos de garantia e assistência, salvo indicação em contrário por parte do cliente.</p><p><strong>6. Armazenamento dos seus Dados Pessoais</strong></p><p>Os dados pessoais recolhidos e tratados pela Cozinhas PL são armazenados em servidores com acesso limitado, localizados em instalações controladas.</p><p><strong>7. Transferências de dados para o estrangeiro</strong></p><p>Caso a prestação de determinados serviços pela Cozinhas PL implique a transferência dos dados pessoais dos utilizadores para fora de Portugal, a Cozinhas PL cumprirá rigorosamente as disposições legais aplicáveis, nomeadamente quanto à determinação da adequabilidade de tal País no que respeita a proteção de dados pessoais e aos requisitos aplicáveis a tais transferências.</p><p><strong>8. Medidas de segurança</strong></p><p>Para evitar a divulgação ou acesso não autorizado e para assegurar uma utilização apropriada dos dados pessoais dos utilizadores, a Cozinhas PL recorre a procedimentos físicos, técnicos e administrativos apropriados e razoáveis para salvaguardar a informação que recolhe e trata, de forma a proteger os dados pessoais contra a sua difusão, perda, uso indevido, alteração, tratamento ou acesso não autorizado bem como, contra qualquer outra forma de tratamento ilícito.</p><p>Para esse efeito, para além da utilização de protocolo HTTP sobre uma camada adicional de segurança que utiliza o protocolo SSL/TLS (HTTPS), o seu sistema encripta a informação para garantir que os mesmos não são objeto de interceção quando transmitidos através da rede e tem implementados sistemas de autenticação / controlo de acessos (login e password) e utilização de firewalls.</p><p><strong>9. Cookies</strong></p><p>Este website utiliza cookies para melhorar o seu serviço. Alguns cookies são essenciais para garantir as funcionalidades disponibilizadas, enquanto outros são destinadas a melhorar o desempenho e a experiência do utilizador. Não deverá continuar a aceder ao nosso website após o alerta sobre os cookies, se não concordar com a sua utilização. Para mais informações sobre os cookies usados por este website e forma de os gerir e modificar, por favor consulte a nossa Política de cookies.</p><p><strong>10. Direitos dos Titulares dos Dados</strong></p><p>De acordo com a legislação em vigor, o utilizador tem direito de acesso e retificação dos seus dados pessoais, bem como o direito de solicitar a sua eliminação, opor-se ao seu tratamento e obter a sua limitação ou portabilidade na medida em que seja aplicável.</p><p>Pode igualmente opor-se a que os seus dados sejam utilizados com o fim de criação do seu perfil de cliente; neste caso, não poderá beneficiar de ofertas ou serviços personalizados. Além disso, pode, a qualquer momento, pedir para deixar de receber as nossas comunicações para efeitos de marketing e publicidade.</p><p>Estes direitos podem ser exercidos entrando diretamente em contacto com a Cozinhas PL:</p><p>-por correio: Rua da Cepeda, Nº 8, 4820-202 Fafe</p><p>-por e-mail: rgpd@cozinhaspl.com</p><p><strong>11. Ligação para redes sociais</strong></p><p>Permitimos a ligação a redes sociais, mas não somos responsáveis pelas suas políticas de privacidade e segurança. Recomendamos que as verifique.</p><p>Trata-se de ligações a redes sociais externas à empresa Cozinhas PL sujeitas a Políticas de Privacidade próprias. Estas redes poderão registar a informação relativa às atividades dos utilizadores na Internet, incluindo no nosso sítio da Internet.</p><p>Recomendamos a análise das condições de utilização e das políticas de privacidade destas redes sociais, de modo a saber exatamente como estas utilizam os dados pessoais dos utilizadores, bem como o procedimento para eliminar ou limitar o tratamento desses dados.</p><p><strong>12. Crianças</strong></p><p>A Cozinhas PL não recolhe conscientemente dados pessoais de crianças com idade inferior a dezoito anos. Se tiver menos de dezoito anos, não nos ceda dados pessoais. Se acredita que um menor cedeu dados pessoais à empresa Cozinhas PL entre em contacto connosco para envidarmos todos os esforços no sentido de apagar esses dados pessoais das nossas bases de dados.</p><p><strong>13. Direito aplicável</strong></p><p>Em caso de controvérsia ou reclamação de qualquer natureza relacionada com este website será aplicável a lei portuguesa, independentemente de qualquer conflito de leis aplicáveis. Sem prejuízo de apresentação de queixa junto da autoridade de controlo nacional identificada 2.2, as partes acordam que todas as ações ou procedimentos legais decorrentes ou relacionados com esta Política de Privacidade, serão da competência dos tribunais portugueses e aceitam submeter qualquer litígio relativo a esta matéria à competência do Tribunal Judicial da Comarca de Braga.</p><p><strong>14. Atualizações da Presente Política de Privacidade</strong></p><p>Esta Política de Privacidade está sujeita a alterações. A indicação da data da última atualização a este documento consta da legenda “Atualizada em”, no cabeçalho deste documento. As alterações a esta Política de Privacidade entrarão em vigor no momento da sua publicação no website.</p>', 'paginas/8122233370.webp', '2020-04-23', 'Política de privacidade', NULL, 0, NULL, 'politica_de_privacidade', 1, 1, 1, 0),
	(3, 15, 'Política de Cookies', NULL, 'fdsgfd', '<p>&nbsp;</p> <p>Este website utiliza <i>cookies</i> para melhorar o seu serviço.</p> <p><br>&nbsp;</p> <p><strong>1. O que são </strong><i><strong>cookies</strong></i>?</p> <p>Os <i>cookies</i> são pequenos ficheiros de texto que um web<i>site</i>, ao ser visitado pelo utilizador, coloca no seu computador ou no seu dispositivo móvel através do navegador de internet (browser). A colocação de <i>cookies</i> ajudará o <i>site</i> a reconhecer o seu dispositivo na próxima vez que o utilizador o visita.&nbsp;</p> <p><br>Usamos o termo <i>cookies</i> nesta política para referir todos os ficheiros que recolhem informações desta forma. .Alguns cookies são essenciais para garantir as funcionalidades disponibilizadas, enquanto outros são destinadas a melhorar o desempenho e a experiência do utilizador. Não deverá continuar a aceder ao nosso <i>website</i> após o alerta sobre os cookies, se não concordar com a sua utilização.</p> <p>&nbsp;</p> <p><strong>Que tipo de c</strong><i><strong>ookies</strong></i><strong> utilizamos</strong>?</p>', NULL, '2021-07-01', 'Política de Cookies', NULL, 0, NULL, 'politica_de_cookies', 1, 1, 1, 0),
	(4, 15, 'RAL e RLL', NULL, NULL, '<p><strong>RAL</strong></p>\r\n<p>Em caso de litígio o consumidor pode recorrer a uma entidade de Resolução Alternativa de Litígios de Consumo (RAL). As entidades de Resolução Alternativa de Litígios de Consumo (RAL) são as entidades autorizadas a efetuar a mediação, conciliação e arbitragem de litígios de consumo em Portugal que estejam inscritas na lista de entidades RAL prevista pela Lei n.º 144/2015.<br />\r\nClique em <a href="http://www.ipai.pt/fotos/gca/i006245_1459446712.pdf" target="_blank">www.ipai.pt/fotos/gca/i006245_1459446712.pdf</a></p>\r\n\r\n<p><strong>RLL</strong></p>\r\n<p>O consumidor pode recorrer à plataforma europeia de resolução de litígios em linha disponível em <a href="https://ec.europa.eu/consumers/odr/main/index.cfm?event=main.home2.show&lng=PT" target="_blank">ec.europa.eu/consumers/odr/main/index.cfm?event=main.home2.show&lng=PT</a></p>', NULL, NULL, 'RAL', NULL, 0, NULL, 'ral_e_rll', 1, 1, 1, 0),
	(5, 15, 'Termos e Condições', NULL, NULL, '<p><h1>Termos e Condições</h1></p>', NULL, NULL, 'Termos e condições', NULL, 0, NULL, 'termos_e_condicoes', 0, 0, 1, 0),
	(6, 15, 'Home', NULL, NULL, NULL, NULL, NULL, 'Home', 'Página Inicial', 0, NULL, 'home', 1, 0, 1, 0),
	(7, 15, 'Cozinhas', NULL, 'fsdfsdf', '<p>A cozinha é um espaço central do nosso lar, onde passamos a maior parte do nosso tempo. Esta divisão caracteriza-se por ser um local de partilha de momentos, que eternizamos. A escolha de um estilo para a sua cozinha dependerá do seu estilo pessoal, do espaço disponível, do design da sua casa, entre outros.&nbsp;&nbsp;</p><p>A seleção de um estilo pode tornar-se complexa, por isso, reunimos um conjunto de diferentes estilos e oferecemos aconselhamento profissionalizado.</p><p><br>&nbsp;</p>', NULL, '2021-07-01', 'Cozinhas', 'Todas as cozinhas da empresa', 0, NULL, 'cozinhas', 1, 0, 1, 0),
	(8, 15, 'Projetos', NULL, NULL, NULL, NULL, NULL, 'Projetos', 'Projetos da empresa', 0, NULL, 'projetos', 1, 0, 1, 0),
	(9, 15, 'Catalogos', NULL, NULL, NULL, 'paginas/797401635.webp', NULL, 'Catalogos', 'Catálogos', 0, NULL, 'catalogos', 0, 0, 1, 0),
	(10, 15, 'Materiais', NULL, NULL, '<p>Para o nosso fabrico apenas selecionamos materiais de qualidade. Conheça a vasta oferta que temos ao seu dispor.</p>', NULL, NULL, 'Materiais', 'Materiais', 0, NULL, 'materiais', 1, 0, 1, 0),
	(11, 15, 'Personalizações', NULL, NULL, NULL, NULL, NULL, 'Personalizações', 'personalizações', 0, NULL, 'personalizacoes', 1, 0, 1, 0),
	(12, 15, 'Contactos', NULL, NULL, NULL, NULL, NULL, 'Contactos', 'Contactos', 0, NULL, 'contactos', 1, 0, 1, 0),
	(13, 15, 'Notícias', NULL, NULL, NULL, NULL, NULL, 'Notícias', 'Notícias', 0, NULL, 'noticias', 1, 0, 1, 0);
/*!40000 ALTER TABLE `l_paginas_pt` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_personalizacoes_imagens
CREATE TABLE IF NOT EXISTS `l_personalizacoes_imagens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_personalizacoes` int(11) DEFAULT NULL,
  `id_tipo_imagens` int(11) DEFAULT 0,
  `nome` varchar(50) DEFAULT NULL,
  `alt` varchar(50) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `ordem` int(11) DEFAULT 99,
  `visivel` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `FK_l_personalizacoes_imagens_l_personalizacoes_pt` (`id_personalizacoes`),
  KEY `FK_l_personalizacoes_imagens_l_config_tipo_imagens` (`id_tipo_imagens`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_personalizacoes_imagens: 16 rows
/*!40000 ALTER TABLE `l_personalizacoes_imagens` DISABLE KEYS */;
INSERT INTO `l_personalizacoes_imagens` (`id`, `id_personalizacoes`, `id_tipo_imagens`, `nome`, `alt`, `url`, `ordem`, `visivel`) VALUES
	(6, 12, 0, '489714590.jpg', 'Solução armário inferior para utensílios', 'personalizacoes/489714590.jpg', 99, 1),
	(5, 12, 0, '925278656.jpg', 'Solução armário inferior para utensílios', 'personalizacoes/925278656.jpg', 99, 1),
	(3, 11, 0, '73742461.jpg', 'Solução armários específicos', 'personalizacoes/73742461.jpg', 99, 1),
	(4, 11, 0, '1261120473.jpg', 'Solução armários específicos', 'personalizacoes/1261120473.jpg', 99, 1),
	(7, 12, 0, '881048613.jpg', 'Solução armário inferior para utensílios', 'personalizacoes/881048613.jpg', 99, 1),
	(8, 13, 0, '1120073074.jpg', 'Solução despenseiro', 'personalizacoes/1120073074.jpg', 99, 1),
	(9, 13, 0, '560766095.jpg', 'Solução despenseiro', 'personalizacoes/560766095.jpg', 99, 1),
	(10, 13, 0, '1587004803.jpg', 'Solução despenseiro', 'personalizacoes/1587004803.jpg', 99, 1),
	(11, 13, 0, '587768261.jpg', 'Solução despenseiro', 'personalizacoes/587768261.jpg', 99, 1),
	(12, 14, 0, '228373062.jpg', 'Solução para cantos aproveitados', 'personalizacoes/228373062.jpg', 99, 1),
	(13, 14, 0, '244521264.jpg', 'Solução para cantos aproveitados', 'personalizacoes/244521264.jpg', 99, 1),
	(14, 14, 0, '1624192129.jpg', 'Solução para cantos aproveitados', 'personalizacoes/1624192129.jpg', 99, 1),
	(15, 15, 0, '1758515691.jpg', 'Solução para pequenos espaços funcionais', 'personalizacoes/1758515691.jpg', 99, 1),
	(16, 15, 0, '2044016577.jpg', 'Solução para pequenos espaços funcionais', 'personalizacoes/2044016577.jpg', 99, 1),
	(17, 15, 0, '311336020.jpg', 'Solução para pequenos espaços funcionais', 'personalizacoes/311336020.jpg', 99, 1),
	(18, 15, 0, '1407763815.jpg', 'Solução para pequenos espaços funcionais', 'personalizacoes/1407763815.jpg', 99, 1);
/*!40000 ALTER TABLE `l_personalizacoes_imagens` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_personalizacoes_pt
CREATE TABLE IF NOT EXISTS `l_personalizacoes_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `visivel` int(11) DEFAULT 1,
  `ordem` int(11) NOT NULL DEFAULT 99,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_personalizacoes_pt: ~5 rows (approximately)
/*!40000 ALTER TABLE `l_personalizacoes_pt` DISABLE KEYS */;
INSERT INTO `l_personalizacoes_pt` (`id`, `nome`, `titulo`, `imagem`, `descricao`, `title`, `description`, `keywords`, `url`, `visivel`, `ordem`) VALUES
	(11, 'Solução armários específicos', 'Solução armários específicos', 'personalizacoes/372725014.webp', '<p>Esta solução para a área da pia, garante um acesso otimizado ao interior do armário. A extensão em forma de U proporciona um maior aproveitamento para arrumação, por exemplo, esponjas, detergentes líquidos entre outros.</p>', NULL, NULL, NULL, 'solucao_armarios_especificos', 1, 99),
	(12, 'Solução armário inferior para utensílios', 'Solução armário inferior para utensílios', 'personalizacoes/93219778.webp', '<p>Armários inferiores para utensílios ajustados às necessidades.</p><p>O necessário sempre à mão na preparação e elaboração de refeições.</p>\r\n', NULL, NULL, NULL, 'solucao_armario_inferior_para_utensilios', 1, 99),
	(13, 'Solução despenseiro', 'Solução despenseiro', 'personalizacoes/665301752.webp', '<p>Um despenseiro oferece muito mais espaço ao seu projeto de cozinha.</p><p>Através das extensões internas torna-se possível uma maior flexibilidade, proporcionando acesso facilitado por todos os lados. Os sistemas de divisão organizam o espaço disponível de forma a otimizá-lo, garantindo uma maior organização e visibilidade.</p><p>Cada extensão do despenseiro suporta até 70kg de carga total. Até os itens mais pesados são armazenados com segurança.</p>\r\n', NULL, NULL, NULL, 'solucao_despenseiro', 1, 99),
	(14, 'Solução para cantos aproveitados', 'Solução para cantos aproveitados', 'personalizacoes/1449548964.webp', '<p>Os espaços dos cantos nos projetos de cozinhas são na sua generalidade mal aproveitados.</p><p>\r\nO space corner veio resolver esta situação com  a integração de extensões totais, permitindo uma maior aproveitamento do espaço.Com as extensões totais em forma de canto, os utensílios ficam acessíveis no local onde são utilizados com maior frequência.Para uma maior organização no interior dos móveis, é indispensável a integração de um sistema de divisões internas orga-line.</p>\r\n', NULL, NULL, NULL, 'solucao_para_cantos_aproveitados', 1, 99),
	(15, 'Solução para pequenos espaços funcionais', 'Solução para pequenos espaços funcionais', 'personalizacoes/137331843.webp', '<p>Aproveite os pequenos espaços e armários estreitos para criar áreas adicionais de arrumação de frascos, tábuas, condimentos ou grelhas para assar, para a preparação e elaboração de refeições.</p>', NULL, NULL, NULL, 'solucao_para_pequenos_espacos_funcionais', 1, 99);
/*!40000 ALTER TABLE `l_personalizacoes_pt` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_projetos_imagens
CREATE TABLE IF NOT EXISTS `l_projetos_imagens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_projetos` int(11) DEFAULT NULL,
  `id_tipo_imagens` int(11) DEFAULT 0,
  `nome` varchar(50) DEFAULT NULL,
  `alt` varchar(50) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `ordem` int(11) DEFAULT 99,
  `visivel` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `FK_l_projetos_imagens_l_projetos_pt` (`id_projetos`),
  KEY `FK_l_projetos_imagens_l_config_tipo_imagens` (`id_tipo_imagens`),
  CONSTRAINT `FK_l_projetos_imagens_l_config_tipo_imagens` FOREIGN KEY (`id_tipo_imagens`) REFERENCES `l_config_tipo_imagens` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `FK_l_projetos_imagens_l_projetos_pt` FOREIGN KEY (`id_projetos`) REFERENCES `l_projetos_pt` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_projetos_imagens: ~111 rows (approximately)
/*!40000 ALTER TABLE `l_projetos_imagens` DISABLE KEYS */;
INSERT INTO `l_projetos_imagens` (`id`, `id_projetos`, `id_tipo_imagens`, `nome`, `alt`, `url`, `ordem`, `visivel`) VALUES
	(2, 17, 0, '183650294.jpg', 'Projeto 17', 'projetos/183650294.jpg', 99, 1),
	(3, 17, 0, '1600072832.jpg', 'Projeto 17', 'projetos/1600072832.jpg', 99, 1),
	(4, 17, 0, '343058542.jpg', 'Projeto 17', 'projetos/343058542.jpg', 99, 1),
	(5, 16, 0, '1367814409.jpg', 'Projeto 16', 'projetos/1367814409.jpg', 99, 1),
	(6, 16, 0, '1538650363.jpg', 'Projeto 16', 'projetos/1538650363.jpg', 99, 1),
	(7, 16, 0, '1237310997.jpg', 'Projeto 16', 'projetos/1237310997.jpg', 99, 1),
	(8, 16, 0, '60893616.jpg', 'Projeto 16', 'projetos/60893616.jpg', 99, 1),
	(9, 15, 0, '417212390.jpg', 'Projeto 15', 'projetos/417212390.jpg', 99, 1),
	(10, 15, 0, '329836978.jpg', 'Projeto 15', 'projetos/329836978.jpg', 99, 1),
	(11, 15, 0, '2043286842.jpg', 'Projeto 15', 'projetos/2043286842.jpg', 99, 1),
	(12, 15, 0, '269497689.jpg', 'Projeto 15', 'projetos/269497689.jpg', 99, 1),
	(13, 15, 0, '154167877.jpg', 'Projeto 15', 'projetos/154167877.jpg', 99, 1),
	(14, 15, 0, '1773991982.jpg', 'Projeto 15', 'projetos/1773991982.jpg', 99, 1),
	(15, 15, 0, '853989719.jpg', 'Projeto 15', 'projetos/853989719.jpg', 99, 1),
	(16, 15, 0, '978822729.jpg', 'Projeto 15', 'projetos/978822729.jpg', 99, 1),
	(17, 15, 0, '1201171036.jpg', 'Projeto 15', 'projetos/1201171036.jpg', 99, 1),
	(18, 15, 0, '347184590.jpg', 'Projeto 15', 'projetos/347184590.jpg', 99, 1),
	(19, 15, 0, '104132423.jpg', 'Projeto 15', 'projetos/104132423.jpg', 99, 1),
	(20, 14, 0, '1700216431.jpeg', 'Projeto 14', 'projetos/1700216431.jpeg', 99, 1),
	(21, 14, 0, '1025791473.jpeg', 'Projeto 14', 'projetos/1025791473.jpeg', 99, 1),
	(22, 14, 0, '1096906444.jpg', 'Projeto 14', 'projetos/1096906444.jpg', 99, 1),
	(23, 14, 0, '854167447.jpeg', 'Projeto 14', 'projetos/854167447.jpeg', 99, 1),
	(24, 14, 0, '1115128242.jpg', 'Projeto 14', 'projetos/1115128242.jpg', 99, 1),
	(25, 14, 0, '97409324.jpg', 'Projeto 14', 'projetos/97409324.jpg', 99, 1),
	(26, 14, 0, '1478978214.jpeg', 'Projeto 14', 'projetos/1478978214.jpeg', 99, 1),
	(27, 14, 0, '24105928.jpg', 'Projeto 14', 'projetos/24105928.jpg', 99, 1),
	(28, 14, 0, '1562654542.jpeg', 'Projeto 14', 'projetos/1562654542.jpeg', 99, 1),
	(29, 14, 0, '706438843.jpg', 'Projeto 14', 'projetos/706438843.jpg', 99, 1),
	(30, 14, 0, '764306036.jpeg', 'Projeto 14', 'projetos/764306036.jpeg', 99, 1),
	(31, 14, 0, '630500934.jpeg', 'Projeto 14', 'projetos/630500934.jpeg', 99, 1),
	(32, 14, 0, '1697452056.jpeg', 'Projeto 14', 'projetos/1697452056.jpeg', 99, 1),
	(33, 13, 0, '895682943.jpg', 'Projeto 13', 'projetos/895682943.jpg', 99, 1),
	(34, 13, 0, '1811684327.jpg', 'Projeto 13', 'projetos/1811684327.jpg', 99, 1),
	(35, 13, 0, '2120645418.jpg', 'Projeto 13', 'projetos/2120645418.jpg', 99, 1),
	(36, 13, 0, '593551696.jpg', 'Projeto 13', 'projetos/593551696.jpg', 99, 1),
	(37, 13, 0, '2110500847.jpg', 'Projeto 13', 'projetos/2110500847.jpg', 99, 1),
	(38, 13, 0, '1937334859.jpg', 'Projeto 13', 'projetos/1937334859.jpg', 99, 1),
	(39, 13, 0, '2078536350.jpg', 'Projeto 13', 'projetos/2078536350.jpg', 99, 1),
	(40, 13, 0, '437401849.jpg', 'Projeto 13', 'projetos/437401849.jpg', 99, 1),
	(41, 13, 0, '796924264.jpg', 'Projeto 13', 'projetos/796924264.jpg', 99, 1),
	(42, 13, 0, '862896334.jpg', 'Projeto 13', 'projetos/862896334.jpg', 99, 1),
	(43, 13, 0, '2120256206.jpg', 'Projeto 13', 'projetos/2120256206.jpg', 99, 1),
	(44, 13, 0, '337542615.jpg', 'Projeto 13', 'projetos/337542615.jpg', 99, 1),
	(45, 13, 0, '1310523279.jpg', 'Projeto 13', 'projetos/1310523279.jpg', 99, 1),
	(46, 13, 0, '558090107.jpg', 'Projeto 13', 'projetos/558090107.jpg', 99, 1),
	(47, 12, 0, '1270664663.jpg', 'Projeto 12', 'projetos/1270664663.jpg', 99, 1),
	(48, 12, 0, '1442272337.jpg', 'Projeto 12', 'projetos/1442272337.jpg', 99, 1),
	(49, 12, 0, '345005059.jpg', 'Projeto 12', 'projetos/345005059.jpg', 99, 1),
	(50, 11, 0, '1439466069.jpg', 'Projeto 11', 'projetos/1439466069.jpg', 99, 1),
	(51, 11, 0, '1981101052.jpg', 'Projeto 11', 'projetos/1981101052.jpg', 99, 1),
	(52, 11, 0, '192121650.jpg', 'Projeto 11', 'projetos/192121650.jpg', 99, 1),
	(53, 11, 0, '1493151522.jpg', 'Projeto 11', 'projetos/1493151522.jpg', 99, 1),
	(54, 10, 0, '784550095.jpg', 'Projeto 10', 'projetos/784550095.jpg', 99, 1),
	(55, 10, 0, '1882335459.jpg', 'Projeto 10', 'projetos/1882335459.jpg', 99, 1),
	(56, 10, 0, '1182162745.jpg', 'Projeto 10', 'projetos/1182162745.jpg', 99, 1),
	(57, 9, 0, '1621983025.jpg', 'Projeto 9', 'projetos/1621983025.jpg', 99, 1),
	(58, 9, 0, '2106887292.jpg', 'Projeto 9', 'projetos/2106887292.jpg', 99, 1),
	(59, 9, 0, '1085990321.jpg', 'Projeto 9', 'projetos/1085990321.jpg', 99, 1),
	(60, 9, 0, '4575801.jpg', 'Projeto 9', 'projetos/4575801.jpg', 99, 1),
	(61, 9, 0, '1112404498.jpg', 'Projeto 9', 'projetos/1112404498.jpg', 99, 1),
	(62, 9, 0, '347888853.jpg', 'Projeto 9', 'projetos/347888853.jpg', 99, 1),
	(63, 8, 0, '1902681091.jpeg', 'Projeto 8', 'projetos/1902681091.jpeg', 99, 1),
	(64, 8, 0, '693808666.jpeg', 'Projeto 8', 'projetos/693808666.jpeg', 99, 1),
	(65, 8, 0, '1213785102.jpeg', 'Projeto 8', 'projetos/1213785102.jpeg', 99, 1),
	(66, 8, 0, '283816538.jpeg', 'Projeto 8', 'projetos/283816538.jpeg', 99, 1),
	(67, 8, 0, '93906458.jpeg', 'Projeto 8', 'projetos/93906458.jpeg', 99, 1),
	(68, 8, 0, '493792872.jpeg', 'Projeto 8', 'projetos/493792872.jpeg', 99, 1),
	(69, 8, 0, '1511601964.jpeg', 'Projeto 8', 'projetos/1511601964.jpeg', 99, 1),
	(70, 7, 0, '41529016.jpeg', 'Projeto 7', 'projetos/41529016.jpeg', 99, 1),
	(71, 7, 0, '501557618.jpeg', 'Projeto 7', 'projetos/501557618.jpeg', 99, 1),
	(72, 7, 0, '1628616066.jpeg', 'Projeto 7', 'projetos/1628616066.jpeg', 99, 1),
	(73, 7, 0, '521477598.jpeg', 'Projeto 7', 'projetos/521477598.jpeg', 99, 1),
	(74, 7, 0, '1746684949.jpeg', 'Projeto 7', 'projetos/1746684949.jpeg', 99, 1),
	(75, 7, 0, '1328515558.jpeg', 'Projeto 7', 'projetos/1328515558.jpeg', 99, 1),
	(76, 7, 0, '2097747750.jpeg', 'Projeto 7', 'projetos/2097747750.jpeg', 99, 1),
	(77, 7, 0, '634550400.jpeg', 'Projeto 7', 'projetos/634550400.jpeg', 99, 1),
	(78, 6, 0, '1868776860.jpg', 'Projeto 6', 'projetos/1868776860.jpg', 99, 1),
	(79, 6, 0, '596383655.jpg', 'Projeto 6', 'projetos/596383655.jpg', 99, 1),
	(80, 6, 0, '1777033610.jpg', 'Projeto 6', 'projetos/1777033610.jpg', 99, 1),
	(81, 6, 0, '1691555660.jpg', 'Projeto 6', 'projetos/1691555660.jpg', 99, 1),
	(82, 6, 0, '31286413.jpg', 'Projeto 6', 'projetos/31286413.jpg', 99, 1),
	(83, 6, 0, '234225868.jpg', 'Projeto 6', 'projetos/234225868.jpg', 99, 1),
	(84, 6, 0, '1345789418.jpg', 'Projeto 6', 'projetos/1345789418.jpg', 99, 1),
	(85, 6, 0, '745145109.jpg', 'Projeto 6', 'projetos/745145109.jpg', 99, 1),
	(86, 6, 0, '1270018474.jpg', 'Projeto 6', 'projetos/1270018474.jpg', 99, 1),
	(87, 6, 0, '1209461731.jpg', 'Projeto 6', 'projetos/1209461731.jpg', 99, 1),
	(88, 5, 0, '334726586.jpg', 'Projeto 5', 'projetos/334726586.jpg', 99, 1),
	(89, 5, 0, '454168929.jpg', 'Projeto 5', 'projetos/454168929.jpg', 99, 1),
	(90, 5, 0, '768717198.jpg', 'Projeto 5', 'projetos/768717198.jpg', 99, 1),
	(91, 5, 0, '2130003986.jpg', 'Projeto 5', 'projetos/2130003986.jpg', 99, 1),
	(92, 5, 0, '1621195321.jpg', 'Projeto 5', 'projetos/1621195321.jpg', 99, 1),
	(93, 5, 0, '652884666.jpg', 'Projeto 5', 'projetos/652884666.jpg', 99, 1),
	(94, 4, 0, '870048754.jpeg', 'Projeto 4', 'projetos/870048754.jpeg', 99, 1),
	(95, 4, 0, '527937156.jpeg', 'Projeto 4', 'projetos/527937156.jpeg', 99, 1),
	(96, 2, 0, '1171201211.jpg', 'Projeto 2', 'projetos/1171201211.jpg', 99, 1),
	(97, 2, 0, '472808039.jpg', 'Projeto 2', 'projetos/472808039.jpg', 99, 1),
	(98, 2, 0, '1179901942.jpg', 'Projeto 2', 'projetos/1179901942.jpg', 99, 1),
	(99, 2, 0, '1305813468.jpg', 'Projeto 2', 'projetos/1305813468.jpg', 99, 1),
	(100, 2, 0, '599090300.jpg', 'Projeto 2', 'projetos/599090300.jpg', 99, 1),
	(101, 2, 0, '1836567960.jpg', 'Projeto 2', 'projetos/1836567960.jpg', 99, 1),
	(102, 2, 0, '1749354935.jpg', 'Projeto 2', 'projetos/1749354935.jpg', 99, 1),
	(103, 2, 0, '21536272.jpg', 'Projeto 2', 'projetos/21536272.jpg', 99, 1),
	(105, 3, 0, '1119313458.jpg', 'Projeto 3', 'projetos/1119313458.jpg', 99, 1),
	(106, 3, 0, '1549186534.jpg', 'Projeto 3', 'projetos/1549186534.jpg', 99, 1),
	(107, 3, 0, '1884630335.jpg', 'Projeto 3', 'projetos/1884630335.jpg', 99, 1),
	(108, 3, 0, '167153626.jpg', 'Projeto 3', 'projetos/167153626.jpg', 99, 1),
	(109, 3, 0, '671620320.jpg', 'Projeto 3', 'projetos/671620320.jpg', 99, 1),
	(110, 3, 0, '2098323419.jpg', 'Projeto 3', 'projetos/2098323419.jpg', 99, 1),
	(111, 3, 0, '1399991537.jpg', 'Projeto 3', 'projetos/1399991537.jpg', 99, 1),
	(116, 1, 0, '1785929771.jpg', 'Projeto 1', 'projetos/1785929771.jpg', 99, 1),
	(117, 1, 0, '1735656157.jpg', 'Projeto 1', 'projetos/1735656157.jpg', 99, 1);
/*!40000 ALTER TABLE `l_projetos_imagens` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_projetos_pt
CREATE TABLE IF NOT EXISTS `l_projetos_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_categoria` int(11) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `titulo` varchar(50) DEFAULT NULL,
  `ano` int(11) DEFAULT 0,
  `descricao` text DEFAULT NULL,
  `resumo` varchar(255) DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `destaque` int(11) DEFAULT 1,
  `visivel` int(11) DEFAULT 1,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `ordem` int(11) DEFAULT 99,
  PRIMARY KEY (`id`),
  KEY `FK_l_projetos_pt_l_categorias_pt` (`id_categoria`),
  CONSTRAINT `FK_l_projetos_pt_l_categorias_pt` FOREIGN KEY (`id_categoria`) REFERENCES `l_categorias_pt` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_projetos_pt: ~17 rows (approximately)
/*!40000 ALTER TABLE `l_projetos_pt` DISABLE KEYS */;
INSERT INTO `l_projetos_pt` (`id`, `id_categoria`, `nome`, `titulo`, `ano`, `descricao`, `resumo`, `imagem`, `destaque`, `visivel`, `title`, `description`, `keywords`, `url`, `ordem`) VALUES
	(1, 13, 'Fénix e Arpa', NULL, 2021, '<p>As utilizações de diferentes materiais resultam numa maior unicidade dos projetos cozinhas. A cozinha com móveis inferiores em fénix preto, com caixa cinza, orla preta, móveis superiores em arpa, com caixa cinza e colunas e tampo em egger.</p><p>A pequena zona de convívio aberta funciona como uma ponte de interação para o restante espaço.</p>', 'As utilizações de diferentes materiais resultam numa maior unicidade dos projetos cozinhas.', NULL, 0, 1, 'Projeto 1', 'As utilizações de diferentes materiais resultam numa maior unicidade dos projetos cozinhas.', NULL, 'Projeto_1', 2),
	(2, 13, 'Luxe', NULL, 2019, '<p>Neste Projeto, temos uma cozinha em Luxe, tampo silestone e puxadores de encastre huelva. Temos uma área de jantar e de confeção para uma maior versatilidade com várias soluções de armazenamento.</p>', 'Neste Projeto, temos uma cozinha em Luxe, tampo silestone e puxadores de encastre huelva.', NULL, 0, 1, 'Projeto 2', NULL, NULL, 'Projeto_2', 1),
	(3, 43, 'Openspace', NULL, 2021, '<p>Cozinha openspace com zona de ilha, janelas, colunas e nicho em egger.</p>', 'Cozinha openspace com zona de ilha, janelas, colunas e nicho em egger.', NULL, 1, 1, 'Projeto 3', NULL, NULL, 'Projeto_3', 1),
	(4, 43, 'Exposição', NULL, 2021, '<p>Cozinha em egger, fénix preto e dekton sirius.</p><p>Design e a funcionalidade que inspiram.</p>\r\n', 'Cozinha em egger, fénix preto e dekton sirius.', NULL, 1, 1, 'Projeto 4', NULL, NULL, 'Projeto_4', 1),
	(5, 13, 'Projeto 5', NULL, 2019, '<p>Neste projeto, apenas importa o necessário.</p><p>A cozinha em arpa, porta em fin opaca, nicho decorativo, ilha em egger, tampo silestone e meia esquadria.</p><p>O pormenor do nicho em madeira resulta numa maior funcionalidade para organizar e decorar em simultâneo a cozinha.</p>\r\n', 'Neste projeto, apenas importa o necessário.', NULL, 1, 0, 'Projeto 5', NULL, NULL, 'Projeto_5', 1),
	(6, 43, 'Remodelação Guarani', NULL, 2018, '<p>O projeto de remodelação total do restaurante Guarani, executado em 2020, engloba a sala de refeições, balcão e wcs. Para não interferir com as cores utilizadas nas diversas áreas, optamos pela utilização de tons castanhos, pretos e cinzas. Os materiais mais utilizados neste projeto, foram as melaminas e as cerâmicas. Além de se tratar de um projeto totalmente diferente do que estamos habituados a fazer, foi uma experiência nova que nos motivou a fazer o melhor, confira já o resultado final!</p>', 'O projeto de remodelação total do restaurante Guarani, executado em 2020, engloba a sala de refeições, balcão e wcs.', NULL, 1, 1, 'Projeto 6', NULL, NULL, 'Projeto_6', 1),
	(7, 43, 'Projeto 7', NULL, 2019, '<p>Cozinha com portas em fénix preto, puxadores perfil gola preto, tampo em silestone negro, nicho e mesa em egger.</p><p>O preto deste projeto confere mais elegância, combinando perfeitamente com o pormenor em madeira do nicho integrado e da zona de refeições na ilha. A garrafeira integrada funciona como um pormenor de design e ao mesmo tempo funcional.</p>', 'Cozinha com portas em fénix preto, puxadores perfil gola preto, tampo em silestone negro, nicho e mesa em egger.', NULL, 1, 0, 'Projeto 7', NULL, NULL, 'Projeto_7', 1),
	(8, 13, 'Harpa opaca', NULL, 2021, '<p>A originalidade é a palavra que melhor caracteriza este projeto.</p><p>A cozinha em harpa opaca, com puxadores dourados, tampo deckton e mesa finsa marmolhades.</p>', 'A originalidade é a palavra que melhor caracteriza este projeto.', NULL, 1, 1, 'Projeto 8', NULL, NULL, 'Projeto_8', 1),
	(9, 13, 'Projeto 9', NULL, 2019, '<p>Cozinha em meia esquadria, arpa, tampo em dekton entzo e espelho bronze.</p><p>Este projeto é um openspace moderno, com uma área generosa para arrumação.</p>\r\n', 'Cozinha em meia esquadria, arpa, tampo em dekton entzo e espelho bronze.', NULL, 1, 0, 'Projeto 9', NULL, NULL, 'Projeto_9', 1),
	(10, 43, 'Projeto 10', NULL, 2020, '<p>Cozinha em luxe brilho, melamina, parede silestone e puxador hide.</p>', 'Cozinha em luxe brilho, melamina, parede silestone e puxador hide.', NULL, 1, 0, 'Projeto 10', NULL, NULL, 'Projeto_10', 1),
	(11, 13, 'Lacada', NULL, 2018, '<p>Cozinha em aura, com puxador em concha ouro velho, porta com moldura, silestone e espelho bronze.</p><p>O estilo nórdico confere descontração, leveza e aconchego aos diferentes espaços abertos.</p>\r\n', 'Cozinha em aura, com puxador em concha ouro velho, porta com moldura, silestone e espelho bronze.', NULL, 1, 1, 'Projeto 11', NULL, NULL, 'Projeto_11', 1),
	(12, 13, 'Península', NULL, 2020, '<p>Neste projeto temos um  maior  aproveitamento do espaço com o objetivo de ter mais bancadas de trabalho,espaços para arrumação e zona de lavagem separada da zona de cozinha. Primamos pelo espaço de integração, área de cozinha e de convívio, integrando uma zona de refeições, mantendo o conceito de openspace.</p><p>A cozinha em fénix, com melamina, finsa e tampo em dekton. São utilizadas  tonalidades neutras para não comprometer as restantes neste espaço. Os apontamentos em madeira e a pedra raiada são pormenores que enriquecem a personalidade deste projeto.</p>\r\n', 'Neste projeto temos um  maior  aproveitamento do espaço com o objetivo de ter mais bancadas de trabalho,espaços para arrumação e zona de lavagem separada da zona de cozinha.', NULL, 1, 1, 'Projeto 12', NULL, NULL, 'Projeto_12', 1),
	(13, 43, 'Residências Marselha ', NULL, 2019, '<p>As residências universitárias de Marselha caracterizam-se por um espaço destinado a estudantes, turistas, pessoas em trabalho, prática desportiva e lazer.</p><p>O projeto de residências consistiu numa construção nova que englobou o fabrico de cozinhas, roupeiros, móveis tv, cabeceiras de cama, prateleiras e escritórios.</p><p>Os materiais mais utilizados neste projeto foram os termolaminados, egger e  puxadores meia esquadria. Temos roupeiros egger e portas em mdf.  O mobiliário de casa de banho é em egger com tampo em corian.</p><p>As prateleiras e cabeceiras de cama são em carvalho verniz natural. O mobiliário de separação é composto por portas em lacado branco com tampo em carvalho de verniz natural. Por último, o mobiliário de escritório em carvalho de verniz natural.</p>', 'As residências universitárias de Marselha caracterizam-se por um espaço destinado a estudantes, turistas, pessoas em trabalho, prática desportiva e lazer.', NULL, 1, 1, 'Projeto 13', NULL, NULL, 'Projeto_13', 1),
	(14, 13, 'Residências  Montpellier', NULL, 2021, '<p>O projeto de residências em Montpellier é uma construção nova realizada em 2019, que englobou cozinhas, roupeiros, móveis tv, wcs’s, cabeceiras de cama, prateleiras e escritórios.</p><p>Os materiais mais utilizados neste projeto foram o cracked oak, estratificado, MDF, egger, madeira carvalho natural e corian.</p>', 'O projeto de residências em Montpellier é uma construção nova realizada em 2019, que englobou cozinhas, roupeiros, móveis tv, wcs’s, cabeceiras de cama, prateleiras e escritórios.', NULL, 1, 1, 'Projeto 14', NULL, NULL, 'Projeto_14', 1),
	(15, 13, 'Meia esquadria', NULL, 2020, '<p>Um projeto com junções de pedras, padrões e texturas. Uma aposta com personalidade!</p><p>A Cozinha é  meia esquadria, colunas e zona de refeição em fénix, colunas de eletrodomésticos em  egger, tampo iron e dekton, com  revestimento parede em neolith óxido.</p> \r\n', 'Um projeto com junções de pedras, padrões e texturas. Uma aposta com personalidade!', NULL, 1, 1, 'Projeto 15', NULL, NULL, 'Projeto_15', 1),
	(16, 13, 'Projeto 16', NULL, 2019, '<p>A cozinha com móveis inferiores e superiores em arpa, colunas e revestimento parede em egger, tampo e rodamão em silestone, puxador em meia esquadria.</p><p>O projeto em causa implicou um trabalho acrescido ao nosso departamento de design, pela reduzida  dimensão e formato do espaço disponível.</p>\r\n', 'A cozinha com móveis inferiores e superiores em arpa, colunas e revestimento parede em egger, tampo e rodamão em silestone, puxador em meia esquadria.', NULL, 1, 0, 'Projeto 16', NULL, NULL, 'Projeto_16', 1),
	(17, 13, 'Egger', NULL, 2019, '<p>Pequenos espaços tornam-se apostas completas em  funcionalidade, design e qualidade.</p><p>A cozinha com móveis superiores  e colunas arrumação em abet. As filores e laterais em arden. Os móveis inferiores, coluna de forno e frigorífico em egger.</p><p>A zona de café dá o toque que faltava.</p>\r\n', 'Pequenos espaços tornam-se apostas completas em  funcionalidade, design e qualidade.', NULL, 1, 1, NULL, NULL, NULL, 'Projeto_17', 1);
/*!40000 ALTER TABLE `l_projetos_pt` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_testemunhos_pt
CREATE TABLE IF NOT EXISTS `l_testemunhos_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) DEFAULT NULL,
  `texto` text DEFAULT NULL,
  `autor` varchar(100) DEFAULT NULL,
  `ordem` int(2) DEFAULT 99,
  `visivel` int(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_testemunhos_pt: ~6 rows (approximately)
/*!40000 ALTER TABLE `l_testemunhos_pt` DISABLE KEYS */;
INSERT INTO `l_testemunhos_pt` (`id`, `titulo`, `texto`, `autor`, `ordem`, `visivel`) VALUES
	(4, 'Empresa certa Bons preços', 'Se procura uma cozinha moderna e acolhedora, é a empresa certa Bons preços!', 'Albino Marques', 99, 1),
	(5, 'Melhor!', 'Pessoal do melhor!', 'Luís Rocha', 99, 1),
	(6, 'Great service!', 'Great business, great service!', 'Herman van Katwijk', 99, 1),
	(7, 'Ficou incrível', 'A minha cozinha com ilha ficou incrível. Amo!', 'Cristina Ribeiro', 99, 1),
	(8, 'Escolhi a empresa pela garantia de qualidade que dão', 'Tenho uma cozinha das cozinhas PL com mais de 20 anos. Não me deu nenhum problema até então. Escolhi a empresa pela garantia de qualidade que dão. ', 'Carlos Machado', 99, 1),
	(9, 'Muito feliz com o resultado final!', 'Muito feliz com o resultado final! Muito obrigada, Cozinhas PL!', '...', 99, 1);
/*!40000 ALTER TABLE `l_testemunhos_pt` ENABLE KEYS */;

-- Dumping structure for table cozinhaspl_site.l_textos_pt
CREATE TABLE IF NOT EXISTS `l_textos_pt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_categorias_tipos` int(11) DEFAULT NULL,
  `ref` varchar(50) DEFAULT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `titulo` varchar(50) DEFAULT NULL,
  `subtitulo` varchar(50) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `visivel` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `FK_l_textos_pt_l_categorias_tipos_pt` (`id_categorias_tipos`),
  CONSTRAINT `FK_l_textos_pt_l_categorias_tipos_pt` FOREIGN KEY (`id_categorias_tipos`) REFERENCES `l_categorias_tipos_pt` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Dumping data for table cozinhaspl_site.l_textos_pt: ~11 rows (approximately)
/*!40000 ALTER TABLE `l_textos_pt` DISABLE KEYS */;
INSERT INTO `l_textos_pt` (`id`, `id_categorias_tipos`, `ref`, `nome`, `titulo`, `subtitulo`, `descricao`, `imagem`, `visivel`) VALUES
	(1, 7, 'materiais_home', 'Materiais Home', 'Materiais', '', '<p>Para o nosso fabrico apenas selecionamos materiais de qualidade. Conheça a vasta oferta que temos ao seu dispor.</p>', 'textos/607176695.webp', 1),
	(2, 7, 'depoimento_home', 'Depoimentos Home', 'É tão bom cozinhar aqui!', 'Teste', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean nisl turpis, ultricies interdum malesuada nec, consequat mollis odio. Morbi dapibus mattis mauris, a pharetra arcu volutpat vel. In aliquam leo at diam ultricies finibus.asdfasdf</p>', NULL, 1),
	(3, 6, 'nossos_projetos', 'Os nossos projetos', 'Os nossos projetos', '', '<p>Os nossos projetos reais, podem tornar-se numa fonte de inspiração para si.&nbsp;Para isso, resolvemos partilhar alguns projetos consigo para que possa ter ideias para o seu projeto Cozinha.</p>', NULL, 1),
	(4, 1, 'cozinhas_texto', 'cozinhas-texto', 'Cozinhas', NULL, '<p>A cozinha é um espaço central do nosso lar, onde passamos a maior parte do nosso tempo. Esta divisão caracteriza-se por ser um local de partilha de momentos, que eternizamos. A escolha de um estilo para a sua cozinha dependerá do seu estilo pessoal, do espaço disponível, do design da sua casa, entre outros.</p><p>A seleção de um estilo pode tornar-se complexa, por isso, reunimos um conjunto de diferentes estilos e oferecemos aconselhamento profissionalizado.</p>\r\n', NULL, 1),
	(6, 4, 'projetos_texto', 'projetos-texto', 'Projetos', NULL, '<p>Os nossos projetos reais, podem tornar-se numa fonte de inspiração para si.&nbsp;</p><p>Para isso, resolvemos partilhar alguns projetos consigo para que possa ter ideias para o seu projeto Cozinha. Oferecemos também aconselhamento profissional na criação do seu projeto cozinha. Primamos as suas ideias e a sua concretização o mais fielmente possível.</p><p><br>&nbsp;</p><p>&nbsp;</p>', NULL, 1),
	(7, 2, 'materiais_texto', 'materiais-texto', 'Materiais', NULL, '<p>Para o nosso fabrico apenas selecionamos materiais de qualidade. Conheça a vasta oferta que temos ao seu dispor.</p>', NULL, 1),
	(8, 5, 'personalizacoes_texto', 'personalizacoes-texto', 'Personalizações', NULL, '<p>Conheça as soluções ideais para os interiores dos móveis de cozinha dos seus projetos. Melhore o acesso ao interior do armário, para que o necessário esteja sempre à mão.</p><p>Consiga mais espaço para o armazenamento e aproveite os cantos esquecidos do seu projeto cozinha.</p><p>Os pequenos espaços darão origem a armários estreitos o que significa mais áreas de arrumações para os seus projetos.</p>', NULL, 1),
	(9, 3, 'noticias_texto', 'noticias-texto', 'Notícias', NULL, NULL, NULL, 1),
	(10, 9, 'catalogos_texto', 'catalogos-texto', NULL, NULL, NULL, NULL, 1),
	(16, 7, 'footer_novo_projeto', 'Footer - Criar novo projeto', 'Quer criar um novo projeto?', ' ', '<p>Peça Já o seu orçamento e projeto 3D gratuitamente.&nbsp;</p>', NULL, 1),
	(17, 7, 'teste_helena', 'Teste Helena', 'Teste', 'Teste', '<p>Teste</p>', NULL, 1);
/*!40000 ALTER TABLE `l_textos_pt` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
