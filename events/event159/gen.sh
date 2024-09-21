lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.061221221221224 --fixed-mass2 59.85421421421422 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017525726.921242 \
--gps-end-time 1017532926.921242 \
--d-distr volume \
--min-distance 1253.5624367255941e3 --max-distance 1253.582436725594e3 \
--l-distr fixed --longitude 83.93582916259766 --latitude 27.444583892822266 --i-distr uniform \
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
