#!/usr/bin/env bash
#
# scriptTemplate.sh - script template Padrão
# Autor/Manutenção: Jones Willian
#
# ------------------------------------------------------------------------ #
# Modo de execução:
#     $ ./scriptTemplate.sh IP
#
# ------------------------------------------------------------------------ #
# Histórico:
##    v1.0 21/03/2022, Jones Willian:
#   - Criação, Comentários e identação do Código
#
# ------------------------------------------------------------------------ #
# VARIÁVEIS ---------------------------------------------------------------#



# ------------------------------------------------------------------------ #
# TESTES ----------------------------------------------------------------- #
# VALIDA IP
  [ $1 = " " ] && echo "--> IP $1 INVALIDO!" && exit 1
# VALIDA COMUNICAÇÃO
  PING=$(ping -c 2 $1 > /dev/null)
  RET=$?
  [ $RET -ne 0 ] && echo "$1 SEM COMUNICACAO" && exit 1

# ------------------------------------------------------------------------ #
# FUNÇÕES ---------------------------------------------------------------- #
process() {
# TRANSFERINDO ARQUIVOS PARA O HOST
sshpass -p $FPASS rsync -e "ssh -o StrictHostKeyChecking=no" --progress \
  /pdv/vDebug/TCLinux \
  /pdv/vDebug/TCLinux \
pdv@$1:/tmp
# CONECTANDO NO HOST PARA EXECUTAR
sshpass -p $FPASS ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 \
pdv@$1 << EOF
  echo $FPASS | sudo -S cp -prv
  echo $FPASS | sudo -S systemctl
  echo "Processo Finalizado $0 $1"
EOF
}


# ------------------------------------------------------------------------ #
# EXECUÇÃO --------------------------------------------------------------- #
# CÓDIGO
# ------------------------------------------------------------------------ #
