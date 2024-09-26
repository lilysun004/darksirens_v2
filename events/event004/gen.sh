lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 18.756676676676676 --fixed-mass2 54.97965965965966 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022545811.5640655 \
--gps-end-time 1022553011.5640655 \
--d-distr volume \
--min-distance 2493.8734280096246e3 --max-distance 2493.893428009625e3 \
--l-distr fixed --longitude -24.176239013671875 --latitude -63.512245178222656 --i-distr uniform \
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
