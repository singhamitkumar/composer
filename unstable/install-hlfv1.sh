(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else   
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� �-Y �]Ys�Jγ~5/����o�Jմ6 ����)�v6!!~��/ql[7��/�Ht7�V����9ݸ�>Y�Wn��!��S��i�xEiyx��GQ�i��� ��}���Ӝ��dk;�վ�S{;�^.�Z�?�#�'��v��^N�z/��˟�)��xM��)����!�V�/o������r��$EW�/���c��bo�˟@��_~I�s����e \.�0*���k��O'^���r�I�8
�"�;y?��{4%�B��Oj�#��?����ʽ������]��]�<�l�%l���(M�Iظ�E����_��ڎG�.�">��d�5�*�e��4�)�E��d�H���_jH�����#8�!�5�����eb�-Z�<Hi�<�DQ��x�M��`���`5Jq-�j(�����LH-;��Oc7x~��+�\l�M�B ��������y>���>EѨ�(Ds�Ձ���x����d+!u#�dh�J3�'�m�//d])n���-Q�r�u��7��XQ^z����S�����h�t�t�s����T�����qu�x��уg���QǞ���*�_
�^�Y��Bm�j~Y����\�@(k�R�Y��2C�gͥ�m-��0\M�nO�0�BE�r��,�Դ�����A4��A �<��5L���x�Fdb�P�S�S�&mdq���!9�G��9����'��6̅;g�ヸ��B��b�Mn1�zn���A�!⊠���z�ŌG�!i�^=ܧ� v0?�`����Сs͡��Չ�XD���Cq'������Y�M��I[,��oā�q�t1�S�b>��Cso୥bpc�S��L� O
�>
p�����yxsh���H"S�n$L�^�[\c�ƨ��s��/;hS@�N��䒡ʅ�ʻ�R�L�ŭ�L�f�E�F�S q|O�E�5�(�dz�>h���@���=���'�K
P80y�(r�r�,��t�1)m�&Fv��Ê	��R=0�6H�\�h�D�i��&C!J !P�/k<y:9�����	t	#.b�fu0���n����ڹr�Iڒ�hj�x1��C&K f�ȱh�sfы��(�e��F��=3��/��l������(Y�)� �?Jj����S��P��������'����G�y��S��]��H��9Zr;ˇr$��B?b�K����P�I9�S�bqU0U��"��~�Wf�}�"�;� Z�XX���+9$�MY���q��h1Qt+��)�)�a�P_�&N�&.�n��s����2�M���4���j�vZ�b�w� 4��[�.u��z��3w�V�J�Bx��К0
�-�G�H�-MSΌ�5 �$./�@���y����*�q���1�����8�t�܇�.��w|K3ymJ
�(�Hs?4���\rآQ��R�l�9��L�k|'p$�,���&��/�D�0����t��<�1>�@��亖L��)�fV}ȡ�a��?�����k������$IW���C��3���{��F���@��W�������/��7�^��ZdW�_~I���S�������~}��>E8�b�P6[\� �H���0M���H@�.���Ca��(����U�?ʐ�+���P��T�_	� ��o���~�Ѥ���#��u�u<K�s�G ��e�?�����-ض�`FL�9i��e�l)�z�"��Ɨs�3ܠ��Ȃ�`�͍9�Z�+���u�`5J�`�Y��4��ދ_����S�������������/��_��W��U������S�)� �?J������+o�����o�Px$t�0�7[� -x�������]>tl�0�ެ���31��B���d�{*��< }d�ex�I&��T�[ӹg�6|�=̝�*"��"	s=����z���dް��1�?M�B�x��	����NV�;�g���5�H��q9#�����@~���-�A�%�S�q�s ��l(bK Ӑ���s'������m�2	\X�7h�y��磅iϞ�P���I`*����;����C���b��v�in��:K{��,�;�!/7;��
�(!�D��|$s�"yY��	���@N�b�Ak����S���������2�!�������KA��W����������k�����E���K�%���_��������T�_���.���(��@�"�����%��16���ӏ:��O8C������빁����Y�qX$@H�Ei�$)�����P��/��+�������*vE~�Z������֘.�m��H�n�����'/H���?�@�N�ǝ:���А�Q����2�F�	�6v�3�J������nO@�C���V>����3�pN)9��ͪ��w����S�O?�����&���r��O|�)��X�������򿽿L)\.��"��)x��$�޾�.�?��x%�2��i;����Q������a�����?�j��|��gi�.�#s�&]ƦX
u1
�\�e1���F�u� p�`���m�a}�Z(*e����9��T��|>.X��"�?��%�a��bB��vK#�Ļ���Jw�4Q?_����Є/�u�]q��ϥ��
t��yԘ	��G�׌�8��C0�2�v;Dت�L�5Aut_$�=��z���n|��i;�;�?���R�;�(I<��(��2�I��A���B�D���C	�i�7���?�������/��~�s�@��8�Z���� sߐ���<�}��ϒ ���?c�~�0�߃��\�[7�nd���|t�zt4tw�{ρ�4���i疉��O}vJ��y�Jw�m�=b��7��j�66a�'�E�\�n�Y=�c�1<�j2�:�޼9��\�t���[q�\R|o6h&*�n�Q�z���b��G�y��p���s��i�X�s�%�p�wk�ʹ�Q�hMX���UjS����ҝJ���9�[a��5� �RgD��ކ��t�w��n7�5���`��Ԝ��]]q��B[��n;i�圳�xJX9[��1�C�y��L;AO�%�����ӻ�����E�/��4����>R�����?NV�)�-�
����	�3��[��%ʐ�������JW翗������������k���;��4r�����>|�ǽ��O��|�o �my�>��} �{ܖ�^��}�4��r�?9zp Dbl'�����>���$���ld�l�k��e+=5%���ʱkiBÐNe3&ɜ��ep*7<��k����q�W��k�A@O�x�ygs���l��f��9r5��Z�lޥ�ݴo���<k$���Ž������Z�-Xr�\���������i4l����BEا���<{�)>R��t���Q���+���O>�������Ϙ����?e��=���������G��_��W��������N�����0����rp��/��.��B�*��T�_���.���?G��t�����Rp9�a�4��$J1E����>�Q$�8�N�8��(��S��庘�0^��[���b����
��J����2%[N��95c����ͩ����-y#��E������Ds:n+� �Jx����^�����ط�ܱ
#Jj�9��uG� ?��]K'��@9���C�ި��Q��м���^x�;��b�GI����h������Gq�|z���������f���Z���2?�N]?�
�j��/��4�C�km�O�t�{a1�I��k�1�E\���5re/��}����N�x�����Z��&N���4�����.��Z�������8]g��������?�:�7����Z6�]�����Q;�w]�*R����t��^}��о/t�+���������jWN�������$��v坺`/6������KNu��ַ����ڞ.��fiGŨp훻ʠ����p;r���}eX��hluuA�E��!��:7�o�*]���!ק?/�>^�r_�fW�v��kE%��|��^�q������\;�BϾ��.:J�'ߺ�/^--���DYrg��X����}�u��]�E���K�2iA�ϟ�^ܛ������Ӻ8�?��n���6��5x���ߟWe���?��ǒ����4����NM��t>]�7�4�Z��d�qb�'p��p8]O6�u��~0�I�^�=L|�	�!�#%pVϧ�� }T�#���#��Ⱨn��z8e���e.R|Wo�&�U�+�7�H��hȊ��أ�*��o�t�?N6�b�����6���+Ó8[�[;���>[R��É~�fO,�m1����㬢ڮ����6�u����r9<.��r�˘�b���u�K��tݺ�t�ֽoJ�=]�n�֞v��5!&��4�o4B�@�D?)����A	$D�`����ж�z��휝����&�t��y���������y��y0����M���i��������lt1<�d�$3�X�R2��q�ږ�c��'�k ��0�/����n�LˁiVFǢK��0н@4�׀�}2��lnr(aƅ|��yGU�$����C��m��hNԍ��+��Ah�ef�tðJ�@������8X�1�Ȓ�mE�uS�F�ޱJ�3v��qf�zxN�CI���3��dG:��B��LS�n9���^��U�#��!���q����8sq\��CS1��ȬJ�?P��-��oֈ�9|r��xiȘuTx�oU�K��nݜ�E��Y���Ma��M��4�"G�ӥ�l8���hpꛃS�N��N''F~0��|D��uru�N�_T$v �r�UY���`.�u���=�9��jL]�X�A-���,�n"I��,�T�>��V�?d9N�.[<g�tJ��a�yߌ�.#J#����_3�F?�+�ѽ^�ԚbTaFw��A�Y]}(�����%w���:L�Y)c�?fH�z��g �+V����Es��E�R$yP`k�lͼ�����r�������W?���޾���Q%�ق�p:�Xa��ι �g��{p�!���O�,�9����ҭ#2d�c�ǚ����.#&h����Lc<�M��N��ڹt|��w��j�2�]]��dC�ע��.�h�B��k�sˮ�܁�S��^UM���٧<4�7�":�Wv������,l���������5�������������^���@a��Ʃ�����ϯv^k�ą������DO6�"�^�_��Q7��ey4�z=۾jե�
���x8?�y8��3zx�N�;t���kw���?\��Z�|��C�)~���]z�ϟ�^��3حt�	
��\3�C?tB��	�n\z�΍�W�Ϝ��}z�����<���M���M�{��Ma��H֧�y����#rދ�\��r=����F/aL�5�	���xa��B�`h��o3�QX��7, �|��6rDr3o��X��;��%����������2\��4�S�{��Ks�|���z�&��a�2�|=8���fn1/$>g�ۜl�,�I"�6:��s���*�a����t��v����d��"Y��no͢ʤ����il����LH���V��{�o��\�r��bB�3p)(��BB�*��L�l>��^JM)p�뭗B���~�>��S6�f��L�U����"�v�@Xj_�Om�#���'8$�f����bX{j���[�[��kJ6�ƃ��VqW<�$��6�.s����8��+�(Dsy��V�'�ܑPR̄�l��'$ q8d%�a�I#�r
fZp$B�H��Z>�!���1��9d�;�M����V!�Jj���v�V,�#�?�4Y��y�ZJ�Q�\����a�����`��N��\��w�C>?�D��F��W��1)˒Xg�e˝��u�@�Kq��R2��D���L~( �j�@�~�kE��`�n�H�_	��X1��T��D[i�"T�����MNYpF��ZQ�"t�����i��3-)5�,{�gd�*KT��!_���}C�к|�nX9��0vu"Q9�	Ǜ��#����bλU�~p	�T2R�#�&S��
դ�K�}�����*Kl���(Ke���,Q4��
��*\%I��B����Bg�5s����4Ϸ��P�jW�Eyk'�N+�*op;�;�Ĥ� r�}8e	�ɚDp/��2Hz#LʕΔ9�S�=�3�K��	m�ޡ�{[�Z��BI`�7�ҽ��� XB�y�	7�C��[ �ِ���kM�kR��)�=C1�M�l9�nO��i0�)����l����V��6N�F�Os����Zk�}:�v%��A���'֮�8]7�*me��tr買O�Y��L�Y�r��4�VU��]� ��D#�.w�Ѝ�5�j����,���B���A)Y�q�&�Fp�q���%itr�Np1�)�y���̯�6U���~�oi-;Pxh:Nj�$["Np�ٚLm�C7C�����?��}�a�u�N�s�Bg֮�����	K��!hP �T��-�n��ׅ���TyV�Y2��2�������4�(z_�*|�<�2dV�H?�<���-N�U��9�� ���H�����1����!��8�������m}�<���~)X�������Ik�A�EJ=S�b� ȷ��-�Vvn�A���ԑiK�E��Ѡa.:J�p�����,88q4�Q��
���t��"�{����H��p�CS�R�R�_$����(X��]�	�#�--���V����� �y�DP��#[L)��u�6Y��W�Ջ�`��=�*�F�`�@P��)0ZLP��	
i�?���4n�=jb8D,K�$S��CD��x&:����z+1�h��#�F��`�/���;��"]��+CoKAEg���8W�^�|�|cs�hC���T/&[��ER��GP]�6�� LR��r8+70}\�i�^:�����6�8l�8��u�zIwC��N�-S��i�;&�9&>ӊ9˳��C�u*���i+î�;��zX���������}Y<,;������:�d��#l��$�rW�$�c^v��)�����,fPy���8V��3A�IL5(2iE��5eY���0�pyg0aԦ��Ĕ�CdP#����Ʃ-W a�;J��)1-�(L ��%�FH�ܞ.��ax0���p���*&����`��X8l0d7B��yd�]"5����Q�wP��䐨+Q��W���y���bYl�#�����^)U���,���e��F�0�"teK.��w��aMLlI8�st�%y�\/�"�N7��j�)컴���m�q��ǡ��l�o%��}h�l&�
���Br+��6.�[Ͱ]�m�QVk-!�V;\����µ���)��qD�TT^�xM���3|^K�<X�K��߂؄ h��Dq��w���z��8��$�y��N@WXn�E`1�^}�on�^�����^z������������5�aͮ�=|��nv�M'�s�?Q���?q��ypn8�}�?y�������Ѝ�����7o��O~5���OBߋ����;q���]i��گL���6����*�t������Ǟ�b�w�͟qz�5��o~�zz��Q�)�OS���Л���Wmj�M����6M��	��N�+���+����6�Ӧv��N�g�}�����|����pR�*4P?8K��Y.h�m�t�"B�$�1C�-�z���IC��C���y�)j��3��:�g`J�?��<�8l�x�xG�H�5p9������4�e��=gƎ��sf�i�� {Όm�q\�93G��{�)0�cf΅��"��*m��%�#����V��+F��d';��N���_<x�  