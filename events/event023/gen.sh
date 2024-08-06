lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 15.983223223223224 --fixed-mass2 22.622702702702703 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006538242.6238874 \
--gps-end-time 1006545442.6238874 \
--d-distr volume \
--min-distance 1901.5708475404042e3 --max-distance 1901.5908475404042e3 \
--l-distr fixed --longitude 128.9659423828125 --latitude -32.77334976196289 --i-distr uniform \
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
