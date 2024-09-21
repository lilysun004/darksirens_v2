lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 34.220780780780785 --fixed-mass2 17.832192192192192 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020708626.7525119 \
--gps-end-time 1020715826.7525119 \
--d-distr volume \
--min-distance 1114.4193898717403e3 --max-distance 1114.4393898717403e3 \
--l-distr fixed --longitude -71.16183471679688 --latitude -5.0508880615234375 --i-distr uniform \
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
