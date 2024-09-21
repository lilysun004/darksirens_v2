lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 8.839479479479479 --fixed-mass2 63.804284284284286 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019750865.9060249 \
--gps-end-time 1019758065.9060249 \
--d-distr volume \
--min-distance 1417.6397313840348e3 --max-distance 1417.6597313840348e3 \
--l-distr fixed --longitude -62.999847412109375 --latitude 53.59614181518555 --i-distr uniform \
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
