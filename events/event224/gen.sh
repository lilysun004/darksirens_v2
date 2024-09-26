lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.179379379379384 --fixed-mass2 82.12588588588589 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030989526.5778786 \
--gps-end-time 1030996726.5778786 \
--d-distr volume \
--min-distance 2321.1660310616844e3 --max-distance 2321.186031061685e3 \
--l-distr fixed --longitude -82.1685791015625 --latitude -30.410097122192383 --i-distr uniform \
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
