lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.874834834834836 --fixed-mass2 65.06494494494494 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023388237.5253954 \
--gps-end-time 1023395437.5253954 \
--d-distr volume \
--min-distance 1369.2009419907529e3 --max-distance 1369.2209419907529e3 \
--l-distr fixed --longitude 25.144258499145508 --latitude 29.81837272644043 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
