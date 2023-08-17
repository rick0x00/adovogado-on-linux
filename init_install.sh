#!/bin/bash

cd /tmp
mkdir /tmp/workdir
cd /tmp/workdir

function step_java() {
	# DOWNLOAD java
	### no site https://www.java.com/en/download/

	# instalando java
	#sudo mkdit /usr/java
	#sudo tar zxvf jre-8u381-linux-x64.tar.gz -C /usr/java
	#sudo update-alternatives --install "/usr/bin/java" "java" "/usr/java/jre1.8.0_381/bin/java" 1
	echo "------------------------------------------"
	echo "------------------------------------------"
	echo "     INSTALANDO JAVA     "
	echo "------------------------------------------"
	echo "------------------------------------------"

	sudo apt install -y default-jre
}

function step_shodo() {
	# instalando shodo

	echo "------------------------------------------"
	echo "------------------------------------------"
	echo "     INSTALANDo SHODO    "
	echo "------------------------------------------"
	echo "------------------------------------------"

	wget -mEnp -e robots=off -U Mozilla https://pje.trt5.jus.br/shodo/shodo.deb -O shodo.deb

	sudo apt install -y ./shodo.deb
	# execute o shodo
	#java -jar /usr/share/shodo/shodo.jar
}

function step_pjeoffice() {
	# instalando o pjeoffice
	echo "------------------------------------------"
	echo "------------------------------------------"
	echo "  INSTALANDO O PJE OFFICE  "
	echo "------------------------------------------"
	echo "------------------------------------------"

	wget -mEnp -e robots=off -U Mozilla https://cnj-pje-programs.s3-sa-east-1.amazonaws.com/pje-office/pje-office_amd64.deb -O pje-office_amd64.deb

	sudo apt install -y ./pje-office_amd64.deb

	# executando o sistema
	#/usr/share/pje-office/pjeOffice.sh &
}

function step_certificado() {
	# instalando o safesign
	echo "------------------------------------------"
	echo "------------------------------------------"
	echo "  INSTALANDO DRIVER DE CERTIFICADOS       "
	echo "------------------------------------------"
	echo "------------------------------------------"

	#apt install -y libgdbm3_1.8.3-14 libjpeg62-turbo_1.5.2-2+b1 libpng12-0_1.2.50-2+deb8u3 libwxbase2.8-0_2.8.12.1+dfsg2-dmo4 libwxgtk2.8-0_2.8.12.1+dfsg2-dmo4
	#sudo apt install -y libgdbm6 libjpeg62-turbo libpng16-16 libwxbase3.0-0v5 libwxgtk3.0-gtk3-0v5

	#wget https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/Downloads/Linux/libgdbm3_1.8.3-14_amd64.deb
	#wget https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/Downloads/Linux/libjpeg62-turbo_1.5.2-2%2Bb1_amd64.deb
	#wget https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/Downloads/Linux/libpng12-0_1.2.50-2%2Bdeb8u3_amd64.deb
	#wget https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/Downloads/Linux/libwxbase2.8-0_2.8.12.1%2Bdfsg2-dmo4_amd64.deb
	#wget https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/Downloads/Linux/SafeSign.deb

	#sudo dpkg -i ./libgdbm3_1.8.3-14_amd64.deb
	#sudo dpkg -i ./libpng12-0_1.2.50-2+deb8u3_amd64.deb 

	#sudo dpkg -i ./libpng12-0_1.2.50-2%2Bdeb8u3_amd64.deb
	#sudo dpkg -i ./libjpeg62-turbo_1.5.2-2%2Bb1_amd64.deb
	#sudo dpkg -i ./libwxbase2.8-0_2.8.12.1%2Bdfsg2-dmo4_amd64.deb
	#sudo dpkg -i ./SafeSign.deb


	#sudo apt install -y pcscd libccid

	#wget https://s3-sa-east-1.amazonaws.com/shared-www.validcertificadora.com.br/Linux/SafeSign+IC+Standard+Linux+3.5.2.0-AET.000+ub1804+x86_64.deb

	#sudo dpkg -i ./SafeSign+IC+Standard+Linux+3.5.2.0-AET.000+ub1804+x86_64.deb


	wget -mEnp -e robots=off -U Mozilla https://safesign.gdamericadosul.com.br/content/SafeSign_IC_Standard_Linux_ub2204_3.8.0.0_AET.000.zip -O safesign.zip

	unzip safesign.zip

	mv SafeSign*.deb safesign.deb

	# instalando depencendias
	echo "instalando depencendias..."
	sudo apt install -y pcscd libccid
	sudo apt install -y libc6 libstdc++6 libssl3
	echo "instalando safesign..."
	sudo apt install -y ./safesign.deb
	echo "corrigindo pacotes quebrados..."
	sudo apt install -fy
}

function step_serpro() {
	echo "instalando serpro..."
	#echo "configurando chaves do repositorio"
	wget -qO- https://assinadorserpro.estaleiro.serpro.gov.br/repository/AssinadorSERPROpublic.asc | sudo tee /etc/apt/trusted.gpg.d/AssinadorSERPROpublic.asc
	#echo "adicionando repositorio..."
	sudo add-apt-repository 'deb https://assinadorserpro.estaleiro.serpro.gov.br/repository/ universal stable'
	#echo "atualizando espelho do repositorio..."
	sudo apt update
	#echo "instalando serpro..."
	sudo apt install -y assinador-serpro	
}

function step_complementos() {
	echo "------------------------------------------"
	echo "------------------------------------------"
	echo "  INSTALANDO COMPLEMENTOS....      "
	echo "------------------------------------------"
	echo "------------------------------------------"

	echo "instalando firefox..."
	sudo apt install -y firefox

	echo "instalando libreoffice..."
	sudo apt install -y libreoffice

	step_serpro;
}

function step_config_manual() {
	echo "++++++++++++++++++++++++++++++++++++++++++"
	echo "      CONFIGURAÇÕES MANUAIS"
	echo "++++++++++++++++++++++++++++++++++++++++++"
	echo ""
	tokenadmin &
	bg
	echo "caso uma janela ainda não tenha aparecido na tela......"
	echo " 1 - Procure nos softwares do sistemas por 'tokenadmin'"
	echo " 2 - abra o 'tokenadmin'"
	echo " 3 - clique na opção 'integração'"
	echo " 4 - clique em 'Instalar o SafeSign no Firefox...'"
	echo " 5 - conclua a instalação"
	echo ""
	echo ""
	echo "   PRESSIONE <ENTER> DEPOIS DE CONCLUIR AS CONFIGURAÇÕES MANUAIS"
	echo ""
	echo ""
	read
}

function step_configs() {
	echo "------------------------------------------"
	echo "------------------------------------------"
	echo "      CONFIGURANDO SOFTWARES..."
	echo "------------------------------------------"
	echo "------------------------------------------"


homes_name=$(ls /home/)
for home_dir in $homes_name ; do
	mkdir -p /home/${home_dir}/.config/autostart/

	echo "configurando inicialização do pjeOffice..."
	echo '[Desktop Entry]
Type=Application
Exec=/usr/share/pje-office/pjeOffice.sh &
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=startup_pjeoffice
Name=startup_pjeoffice
Comment[en_US]=
Comment=
' > /home/${home_dir}/.config/autostart/pjeoffice.desktop

	echo "configurando inicialização do shodo..."
	echo '[Desktop Entry]
Type=Application
Exec=java -jar /usr/share/shodo/shodo.jar
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=startup_shodo
Name=startup_shodo
Comment[en_US]=
Comment=
' > /home/${home_dir}/.config/autostart/shodo.desktop

	# configurando sites para acesso do java
	mkdir -p /home/${home_dir}/.java/deployment/security/
echo "https://localhost:9000
https://127.0.0.1:9000/#/informacoes
https://127.0.0.1:9000
https://127.0.0.1:9000/#bemvindo
https://pje.cnj.jus.br
https://pje.csjt.jus.br
https://pje.jfce.jus.br/pje/login.seam
https://pje.tjce.jus.br/pje1grau/login.seam
https://pje.tjce.jus.br/pje2grau/login.seam
https://pje.trt7.jus.br/primeirograu/login.seam
https://pje.trt7.jus.br/segundograu/login.seam
https://pje.tre-ce.jus.br:8443/pje-web/login.seam
https://pje.tst.jus.br" > /home/${home_dir}/.java/deployment/security/exception.sites 

done

	#step_config_manual;
}

function step_validacao() {
	echo "------------------------------------------"
	echo "------------------------------------------"
	echo "        VALIDANDO FUNCIONAMENTO           "
	echo "------------------------------------------"
	echo "------------------------------------------"
	echo "================================================================================"
	echo " 1 - Conecte o certificado digital ao commputador..."
	echo " 2 - Acesse o site abaixo para validar o reconhecimento do certificado..."
	echo "  https://ferramentas.safeweb.com.br/TesteTecnico/"
	echo "================================================================================"
}

function step_banner() {
	echo ""
	echo "###########################################################################################"
	echo "###########################################################################################"
	echo ""
	echo " INSTALADOR DO JAVA, SHODO, pjeOffice, DRIVER para certificado digital e complementos"
	echo ""
	echo "###########################################################################################"
	echo " Desenvolvido por Henrique Silva <henriquesilvadotdat@gmail.com>"
	echo "###########################################################################################"
	echo ""

}

function step_finish() {
	echo ""
	echo "###########################################################################################"
	echo "###########################################################################################"
	echo ""
	echo " TODOS OS SISTEMAS FORAM INSTALADOS..."
	echo ""
	echo "###########################################################################################"
	echo " Desenvolvido por Henrique Silva <henriquesilvadotdat@gmail.com>"
	echo "###########################################################################################"
	echo ""

}

#for execute in "step_java step_shodo step_pjeoffice step_certificado step_complementos step_configs step_validacao" ; do

for execute in step_banner step_java step_shodo step_pjeoffice step_certificado step_complementos step_configs step_finish ; do
	$execute
	if [ $? -ne 0 ]; then
		echo " ERROR ao executar \'$execute\'"
		exit 1
	fi
done
