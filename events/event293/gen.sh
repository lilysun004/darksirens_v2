lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 6.906466466466466 --fixed-mass2 26.152552552552553 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012862806.5141972 \
--gps-end-time 1012870006.5141972 \
--d-distr volume \
--min-distance 1263.0398958275482e3 --max-distance 1263.0598958275482e3 \
--l-distr fixed --longitude -135.85690307617188 --latitude -12.00903606414795 --i-distr uniform \
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
