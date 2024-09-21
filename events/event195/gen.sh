lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.094094094094093 --fixed-mass2 78.00772772772773 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030278827.2600373 \
--gps-end-time 1030286027.2600373 \
--d-distr volume \
--min-distance 827.8221168518529e3 --max-distance 827.8421168518529e3 \
--l-distr fixed --longitude -89.22030639648438 --latitude 41.50434112548828 --i-distr uniform \
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
