lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 15.815135135135137 --fixed-mass2 28.337697697697696 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019325289.25101 \
--gps-end-time 1019332489.25101 \
--d-distr volume \
--min-distance 2435.3574469430946e3 --max-distance 2435.377446943095e3 \
--l-distr fixed --longitude -146.0927276611328 --latitude -73.91107940673828 --i-distr uniform \
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
