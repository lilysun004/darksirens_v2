lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 40.18790790790791 --fixed-mass2 69.68736736736737 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002230534.0083501 \
--gps-end-time 1002237734.0083501 \
--d-distr volume \
--min-distance 1876.2147286492977e3 --max-distance 1876.2347286492977e3 \
--l-distr fixed --longitude 158.72174072265625 --latitude 50.45386505126953 --i-distr uniform \
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
