lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 30.27071071071071 --fixed-mass2 32.035635635635636 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003796898.476005 \
--gps-end-time 1003804098.476005 \
--d-distr volume \
--min-distance 941.9541155462208e3 --max-distance 941.9741155462208e3 \
--l-distr fixed --longitude 131.58091735839844 --latitude -26.052284240722656 --i-distr uniform \
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
