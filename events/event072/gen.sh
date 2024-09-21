lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.917477477477476 --fixed-mass2 51.78598598598599 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016927205.1422979 \
--gps-end-time 1016934405.1422979 \
--d-distr volume \
--min-distance 1697.6657773007287e3 --max-distance 1697.6857773007287e3 \
--l-distr fixed --longitude 45.76386260986328 --latitude -69.56314849853516 --i-distr uniform \
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
