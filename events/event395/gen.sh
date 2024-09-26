lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.789549549549548 --fixed-mass2 66.40964964964965 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001376260.065098 \
--gps-end-time 1001383460.065098 \
--d-distr volume \
--min-distance 1908.2413161126713e3 --max-distance 1908.2613161126712e3 \
--l-distr fixed --longitude 149.73406982421875 --latitude -19.139848709106445 --i-distr uniform \
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
