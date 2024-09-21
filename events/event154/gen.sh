lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.57153153153153 --fixed-mass2 40.60812812812813 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028837848.6417835 \
--gps-end-time 1028845048.6417835 \
--d-distr volume \
--min-distance 1742.1934922060007e3 --max-distance 1742.2134922060006e3 \
--l-distr fixed --longitude -113.70083618164062 --latitude -0.5722376704216003 --i-distr uniform \
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
