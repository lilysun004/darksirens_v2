lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 2.5361761761761765 --fixed-mass2 60.94678678678679 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017586196.2979647 \
--gps-end-time 1017593396.2979647 \
--d-distr volume \
--min-distance 355.2497719301778e3 --max-distance 355.2697719301778e3 \
--l-distr fixed --longitude -61.02691650390625 --latitude 12.349127769470215 --i-distr uniform \
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
